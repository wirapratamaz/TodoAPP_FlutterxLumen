import 'package:flutter/material.dart';
import 'package:my_app/models/Book.dart';
import 'package:my_app/my_book_list_screen.dart';
import 'package:my_app/services/api.dart';

class BookRecordDelete extends StatelessWidget {
  // In the constructor, require a Todo.
  const BookRecordDelete({super.key, required this.book});

  // Declare a field that holds the Todo.
  final Book book;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Are you sure to delete Todo ${book.name}?',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyBookListScreen()),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Yes'),
                  onPressed: () {
                    API.deleteBookRecord(book.id.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyBookListScreen()),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
