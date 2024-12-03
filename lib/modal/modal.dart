class BookModal {
  int id;
  String title, author, status, rating, genre; // Added genre

  BookModal({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
    required this.rating,
    required this.genre, // Added genre to constructor
  });

  factory BookModal.fromMap(Map m1) {
    return BookModal(
      id: m1['id'] ?? 0, // Provide default values
      title: m1['title'] ?? 'Unknown Title',
      author: m1['author'] ?? 'Unknown Author',
      status: m1['status'] ?? 'Unknown Status',
      rating: m1['rating'] ?? 'Unknown Rating',
      genre: m1['genre'] ?? 'Unknown Genre', // Handle genre
    );
  }
}

Map<String, dynamic> toMap(BookModal book) {
  return {
    'id': book.id,
    'title': book.title,
    'author': book.author,
    'status': book.status,
    'rating': book.rating,
    'genre': book.genre, // Add genre to the map
  };
}
