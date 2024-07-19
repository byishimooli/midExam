import 'package:flutter/material.dart';
import 'package:library_app/book_details_screen.dart';
import 'package:library_app/DatabaseHelper.dart';
import 'package:library_app/book.dart';
import 'package:library_app/BookEditScreen.dart'; // Import your DatabaseService

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService(); // Database service instance
  List<Book> books = []; // List of books

  @override
  void initState() {
    super.initState();
    _loadBooks(); // Load books from database on screen initialization
  }

  void _loadBooks() async {
    try {
      List<Book> loadedBooks = await _databaseService.books();
      setState(() {
        books = loadedBooks;
      });
    } catch (e) {
      print('Error loading books: $e');
    }
  }

  void _addBook(Book book) async {
    try {
      await _databaseService.insertBook(book);
      _loadBooks(); // Reload books from database after adding
    } catch (e) {
      print('Error adding book: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                books[index].title,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                books[index].author,
                style: const TextStyle(color: Colors.white70),
              ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditBookScreen()),
          ).then((newBook) {
            if (newBook != null) {
              _addBook(newBook); // Add the new book to the database and update the list
            }
          });
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 1, 30, 54),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                // Navigate to Search or perform search-related action
              },
            ),
          ],
        ),
      ),
    );
  }
}
