import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/book_record_create.dart';
import 'package:my_app/book_record_delete.dart';
import 'package:my_app/book_record_detail.dart';
import 'package:my_app/book_record_update.dart';
import 'package:my_app/models/Book.dart';
import 'package:my_app/services/api.dart';

class MyBookListScreen extends StatefulWidget {
  const MyBookListScreen({super.key});

  @override
  _MyBookListScreenState createState() => _MyBookListScreenState();
}

class _MyBookListScreenState extends State<MyBookListScreen> {
  var books = <Book>[];

  _getBooks() {
    API.getBooks().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)['data'];
        books = list.map((model) => Book.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getBooks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigate(context, data) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Todo"),
        automaticallyImplyLeading: false,
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                elevation: 4, // Menambahkan efek bayangan
                child: ListTile(
                  trailing: Wrap(
                    spacing: 12,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookRecordUpdate(id: books[index].id),
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        child: const Icon(Icons.delete),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookRecordDelete(book: books[index]),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  title: Text(books[index].name),
                  subtitle: Text(books[index].description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookRecordDetail(book: books[index]),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BookRecordCreate(),
            ),
          );
        },
      ),
    );
  }
}
