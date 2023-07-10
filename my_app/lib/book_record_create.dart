import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/models/book_record.dart';
import 'package:my_app/my_book_list_screen.dart';
import 'package:my_app/services/api.dart';

class BookRecordCreate extends StatefulWidget {
  const BookRecordCreate({super.key});

  @override
  State<BookRecordCreate> createState() {
    return _BookRecordCreateState();
  }
}

class _BookRecordCreateState extends State<BookRecordCreate> {
  final TextEditingController _controller = TextEditingController();
  Future<BookRecord>? _futureBookRecord;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Todo'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureBookRecord == null)
              ? buildColumn()
              : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Todo'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureBookRecord = API.createBookRecord(_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<BookRecord> buildFutureBuilder() {
    return FutureBuilder<BookRecord>(
      future: _futureBookRecord,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MyBookListScreen();
              })));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
