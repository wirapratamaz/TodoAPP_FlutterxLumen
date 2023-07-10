import 'package:flutter/material.dart';
import 'package:my_app/models/Book.dart';

class BookRecordDetail extends StatelessWidget {
  // In the constructor, require a Todo.
  const BookRecordDetail({super.key, required this.book});

  // Declare a field that holds the Todo.
  final Book book;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(book.description),
      ),
    );
  }
}
