import 'package:flutter/material.dart';
import 'package:library_app/book_details_screen.dart';
import 'package:library_app/BookEditScreen.dart';
import 'package:library_app/book.dart';

class HomeScreen extends StatelessWidget {
  final List<Book> books = [
    Book(
      title: 'Book One',
      author: 'Author One',
      description: 'Description One',
      rating: 4.5,
      isRead: true,
    ),
    Book(
      title: 'Book Two',
      author: 'Author Two',
      description: 'Description Two',
      rating: 3.8,
      isRead: false,
    ),
    // Add more books as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index].title),
            subtitle: Text(books[index].author),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsScreen(book: books[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditBookScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
