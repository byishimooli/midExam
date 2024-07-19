import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:library_app/book.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'books.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE books(title TEXT, author TEXT, description TEXT, rating REAL, isRead INTEGER)',
        );
      },
    );
  }

  Future<void> insertBook(Book book) async {
    final db = await database;
    await db.insert('books', book.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Book>> books() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) {
      return Book(
        title: maps[i]['title'],
        author: maps[i]['author'],
        description: maps[i]['description'],
        rating: maps[i]['rating'],
        isRead: maps[i]['isRead'] == 1 ? true : false,
      );
    });
  }

  Future<void> updateBook(Book book) async {
    final db = await database;
    await db.update(
      'books',
      book.toMap(),
      where: 'title = ?',
      whereArgs: [book.title],
    );
  }

  Future<void> deleteBook(String title) async {
    final db = await database;
    await db.delete(
      'books',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  Future<Directory> getApplicationDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }
}

class CRUDOperations {
  final dbHelper = DatabaseService();

  Future<void> addBook() async {
    Book newBook = Book(
      title: 'Sample Book',
      author: 'Sample Author',
      description: 'Sample Description',
      rating: 4.5,
      isRead: true,
    );

    try {
      await dbHelper.insertBook(newBook);
      print('Book added successfully');
    } catch (e) {
      print('Error adding book: $e');
    }
  }
}
