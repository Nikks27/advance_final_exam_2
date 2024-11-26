class BookModal
{
  int id;
  String title,author,status,rating;

  BookModal({required this.id,required this.title,required this.author,required this.status,required this.rating});

  factory BookModal.fromMap(Map m1)
  {
    return BookModal(id: m1['id'] ?? 0, // Provide default values
      title: m1['title'] ?? 'Unknown Title',
      author: m1['author'] ?? 'Unknown Author',
      status: m1['status'] ?? 'Unknown Status',
      rating: m1['rating'] ?? 'Unknown Rating',
    );
  }
}

Map toMap(BookModal book)
{
  return {
    'id' : book.id,
    'title' : book.title,
    'author' : book.author,
    'status' : book.status,
    'rating' : book.rating,
  };
}