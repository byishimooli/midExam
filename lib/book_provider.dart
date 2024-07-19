import 'package:flutter/material.dart';
import 'package:library_app/DatabaseHelper.dart';
import 'package:library_app/book.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  List<Book> _filteredBooks = [];

  BookProvider(BuildContext context, {required bool listen});

  List<Book> get books => _filteredBooks.isNotEmpty ? _filteredBooks : _books;

  Future<void> fetchBooks() async {
    _books = await DatabaseService().books();
    _filteredBooks = [];
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    await DatabaseService().insertBook(book);
    await fetchBooks();
  }

  Future<void> updateBook(Book book) async {
    await DatabaseService().updateBook(book);
    await fetchBooks();
  }

  Future<void> deleteBook(int id) async {
    await DatabaseService().deleteBook(id as String);
    await fetchBooks();
  }

  // Other methods for sorting and searching books
}
