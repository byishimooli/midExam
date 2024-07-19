// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/BookEditScreen.dart';
import 'package:library_app/book.dart';
import 'package:library_app/book_provider.dart';


class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  // ignore: library_private_types_in_public_api
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Book _book;

  @override
  void initState() {
    super.initState();
    _book = widget.book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_book.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedBook = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(book: _book),
                ),
              );

              if (updatedBook != null) {
                setState(() {
                  _book = updatedBook; // Update the book with the returned data
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final bool? deleteConfirmed = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text('Are you sure you want to delete this book?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );

              if (deleteConfirmed == true) {
               // ignore: use_build_context_synchronously
               BookProvider (context, listen: false).deleteBook(_book.id!);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Author: ${_book.author}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Rating: ${_book.rating}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Description: ${_book.description}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Read: ${_book.isRead ? 'Yes' : 'No'}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

