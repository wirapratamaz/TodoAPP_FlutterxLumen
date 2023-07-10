import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/helper/connection_config.dart';
import 'package:my_app/my_book_list_screen.dart';

Future<BookUpdate> fetchBookUpdate(int id) async {
  final response = await http.get(
    Uri.http(ConnectionConfig.localUrl, "/get-data-id/$id"),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return BookUpdate.fromJson(jsonDecode(response.body)['data']);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load TodoUpdate');
  }
}

Future<BookUpdate> updateBookUpdate(String name, int id) async {
  final response = await http.put(
    Uri.http(ConnectionConfig.localUrl, "/update-data/$id"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'name': name}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return BookUpdate.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update TodoUpdate.');
  }
}

class BookUpdate {
  final int id;
  final String name;

  const BookUpdate({required this.id, required this.name});

  factory BookUpdate.fromJson(Map<String, dynamic> json) {
    return BookUpdate(
      id: json['id'],
      name: json['name'],
    );
  }
}

// void main() {
//   runApp(const BookRecordUpdate());
// }

class BookRecordUpdate extends StatefulWidget {
  final int id;
  const BookRecordUpdate({super.key, required this.id});

  @override
  State<BookRecordUpdate> createState() {
    return _BookRecordUpdateState();
  }
}

class _BookRecordUpdateState extends State<BookRecordUpdate> {
  final TextEditingController _controller = TextEditingController();
  late Future<BookUpdate> _futureBookUpdate;
  late int _id;

  @override
  void initState() {
    super.initState();
    _futureBookUpdate = fetchBookUpdate(widget.id);
    _id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Update Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<BookUpdate>(
            future: _futureBookUpdate,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _controller.text = snapshot.data!.name;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Update Todo Name"),
                      TextField(
                        controller: _controller,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter Todo',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureBookUpdate =
                                updateBookUpdate(_controller.text, _id);
                            WidgetsBinding.instance.addPostFrameCallback((_) =>
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const MyBookListScreen();
                                })));
                          });
                        },
                        child: const Text('Update Data'),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
