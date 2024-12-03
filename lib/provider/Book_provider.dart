import 'package:flutter/widgets.dart';
import '../DB Helper/db_helper.dart';
import '../Service/book_services.dart';
import '../modal/modal.dart';

class BookProvider extends ChangeNotifier {
  var txtTitle = TextEditingController();
  var txtAuthor = TextEditingController();
  var txtStatus = TextEditingController();
  var txtRating = TextEditingController();
  var txtGenre = TextEditingController(); // Added for genre
  var txtSearch = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPass = TextEditingController();

  List bookList = [];
  int id = 0;

  List searchList = [];
  String search = '';
  List searchName = [];

  Future<List<Map<String, Object?>>> getName() async {
    return searchList = await BookHelper.helper.getSearchByCategory(search);
  }

  void searchByName(String value) {
    search = value;
    getName();
    notifyListeners();
  }

  void initDatabase() {
    BookHelper.helper.initDatabase();
  }

  Future<void> insertDatabase({
    required int id,
    required String title,
    required String author,
    String? status, // Made optional
    required String rating,
    required String genre,
  }) async {
    await BookHelper.helper.insertData(
      id: id,
      title: title,
      author: author,
      status: status ?? 'Unknown', // Default value
      rating: rating,
      genre: genre,
    );
  }

  // Future<void> cloudToLocally() async {
  //   final details = await BookServices.services.readDataFromStore().first;
  //   final bookDetails = details.docs.map(
  //         (e) {
  //       final data = e.data();
  //       return BookModal(
  //         id: id,
  //         title: data['title'],
  //         author: data['author'],
  //         status: data['status'] ?? 'Unknown', // Handle null for status
  //         rating: data['rating'],
  //         genre: data['genre'], // Added genre
  //       );
  //     },
  //   ).toList();
  //
  //   for (var book in bookDetails) {
  //     final sync = await BookHelper.helper.DataExist(id);
  //     if (sync) {
  //       await updateData(
  //         id: book.id,
  //         title: book.title,
  //         author: book.author,
  //         status: book.status,
  //         rating: book.rating,
  //         genre: book.genre,
  //       );
  //     } else {
  //       await insertDatabase(
  //         id: book.id,
  //         title: book.title,
  //         author: book.author,
  //         status: book.status,
  //         rating: book.rating,
  //         genre: book.genre,
  //       );
  //     }
  //   }
  // }


  Future<void> cloudToLocally() async {
    final details = await BookServices.services.readDataFromStore().first;
    final bookDetails = details.docs.map(
          (e) {
        final data = e.data();
        return BookModal(
          id: data['id'], // Ensure `id` is correctly fetched from Firestore
          title: data['title'],
          author: data['author'],
          status: data['status'] ?? 'Unknown', // Handle null for status
          rating: data['rating'],
          genre: data['genre'], // Added genre
        );
      },
    ).toList();

    for (var book in bookDetails) {
      final sync = await BookHelper.helper.DataExist(book.id); // Check with correct id
      if (sync) {
        await updateData(
          id: book.id,
          title: book.title,
          author: book.author,
          status: book.status,
          rating: book.rating,
          genre: book.genre,
        );
      } else {
        await insertDatabase(
          id: book.id,
          title: book.title,
          author: book.author,
          status: book.status,
          rating: book.rating,
          genre: book.genre,
        );
      }
    }

    // Ensure local data is updated and UI is refreshed
    await readData();
    notifyListeners();
  }


  Future<void> updateData({
    required int id,
    required String title,
    required String author,
    String? status, // Made optional
    required String rating,
    required String genre,
  }) async {
    await BookHelper.helper.updateData(
      id,
      title,
      author,
      status ?? 'Unknown', // Default value
      rating,
      genre,
    );
  }

  Future<void> deleteData({required int id}) async {
    await BookHelper.helper.deleteData(id);
  }

  Future<List> readData() async {
    bookList = await BookHelper.helper.readAllData();
    notifyListeners();
    return bookList;
  }

  Future<void> booksAddInStore({
    required int id,
    required String title,
    required String author,
    String? status, // Made optional
    required String rating,
    required String genre,
  }) async {
    await BookServices.services.addDataInStore(
      id: id,
      title: title,
      author: author,
      status: status ?? 'Unknown', // Default value
      rating: rating,
      genre: genre,
    );
  }

  void clearAll() {
    txtTitle.clear();
    txtAuthor.clear();
    txtStatus.clear();
    txtRating.clear();
    txtGenre.clear(); // Clear genre text field
    notifyListeners();
  }

  BookProvider() {
    initDatabase();
  }
}
