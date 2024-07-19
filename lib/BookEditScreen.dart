import 'package:flutter/material.dart';
import 'package:library_app/book.dart';


class AddEditBookScreen extends StatefulWidget {
  final Book? book;

  AddEditBookScreen({this.book});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _author;
  late double _rating;
  late String _description;
  late bool _isRead; // Add this line

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _title = widget.book!.title;
      _author = widget.book!.author;
      _rating = widget.book!.rating;
      _description = widget.book!.description;
      _isRead = widget.book!.isRead; // Initialize _isRead with book's isRead value
    } else {
      _title = '';
      _author = '';
      _rating = 0.0;
      _description = '';
      _isRead = false; // Initialize _isRead as false for a new book
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _author,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
                onSaved: (value) {
                  _author = value!;
                },
              ),
              TextFormField(
                initialValue: _rating.toString(),
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final rating = double.tryParse(value!);
                  if (rating == null || rating < 0 || rating > 5) {
                    return 'Please enter a rating between 0 and 5';
                  }
                  return null;
                },
                onSaved: (value) {
                  _rating = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              CheckboxListTile(
                title: Text('Read'),
                value: _isRead,
                onChanged: (value) {
                  setState(() {
                    _isRead = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final book = Book(
                      id: widget.book?.id,
                      title: _title,
                      author: _author,
                      rating: _rating,
                      isRead: _isRead, // Pass _isRead to Book constructor
                      description: _description,
                    );
                    // Here you would normally add/update your book using your preferred method (e.g., database, file storage).
                    // For simplicity, I'm using print statements to simulate the behavior.
                    try {
                      if (widget.book == null) {
                        print('Adding book: $book');
                        // Replace with your actual add book logic
                      } else {
                        print('Updating book: $book');
                        // Replace with your actual update book logic
                      }
                      Navigator.pop(context, book); // Pass the updated book back
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An error occurred: $e')),
                      );
                    }
                  }
                },
                child: Text(widget.book == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
