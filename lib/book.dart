class Book {
   int? id;
  final String title;
  final String author;
  final double rating;
   bool isRead;
  final String description;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.isRead,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'rating': rating,
      'isRead': isRead ? 1 : 0,
    };
  }

  void toggleReadStatus() {
    isRead = !isRead;
  }
}
