class BookModal
{
  int? id;
  String? title,athor;

  BookModal({this.id,this.title,this.athor});

  factory BookModal.fromMap(Map m1)
  {
    return BookModal(id: m1['id'],title: m1['title'],athor: m1['athor']);
  }
}

Map toMap(BookModal Book)
{
  return {
    'id' : Book.id,
    'title' : Book.title,
    'athor' : Book.athor,
  };
}