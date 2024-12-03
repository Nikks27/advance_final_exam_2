

import 'package:advance_final_exam_2/Service/auth_service.dart';
import 'package:advance_final_exam_2/view/screen/seach_screen.dart';
import 'package:advance_final_exam_2/view/screen/signIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modal/modal.dart';
import '../../provider/Book_provider.dart';
import 'component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<BookProvider>(context);
    var providerFalse = Provider.of<BookProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              providerFalse.cloudToLocally();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            icon: Icon(Icons.sync),
          ),
          IconButton(
            onPressed: () {
              List<BookModal> book = [];
              book = providerTrue.bookList
                  .map((e) => BookModal.fromMap(e))
                  .toList();

              for (int i = 0; i < providerTrue.bookList.length; i++) {
                providerFalse.booksAddInStore(
                  id: book[i].id,
                  title: book[i].title,
                  author: book[i].author,
                  genre: book[i].genre,
                  rating: book[i].rating,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
           icon: Icon(Icons.backup),
          ),
          IconButton(
            onPressed: () async {
              await AuthService.authService.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Search',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: providerFalse.readData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<BookModal> book = [];
                  book = providerTrue.bookList
                      .map((e) => BookModal.fromMap(e))
                      .toList();
                  return ListView.builder(
                    itemCount: book.length,
                    itemBuilder: (context, index) => Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        onTap: () {
                          providerTrue.id = book[index].id;
                          providerTrue.txtTitle.text = book[index].title;
                          providerTrue.txtAuthor.text = book[index].author;
                          providerTrue.txtGenre.text = book[index].genre;
                          providerTrue.txtRating.text = book[index].rating;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Update Contact'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyTextField(
                                    controller: providerTrue.txtTitle,
                                    name: 'Title',
                                  ),
                                  SizedBox(height: 10),
                                  MyTextField(
                                    controller: providerTrue.txtAuthor,
                                    name: 'Author',
                                  ),
                                  SizedBox(height: 10),
                                  MyTextField(
                                    controller: providerTrue.txtGenre,
                                    name: 'Genre',
                                  ),
                                  SizedBox(height: 10),
                                  MyTextField(
                                    controller: providerTrue.txtRating,
                                    name: 'Rating',
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    providerFalse.updateData(
                                      id: providerTrue.id,
                                      title: providerTrue.txtTitle.text,
                                      author: providerTrue.txtAuthor.text,
                                      genre: providerTrue.txtGenre.text,
                                      rating: providerTrue.txtRating.text,
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        tileColor: (book[index].genre == "read")
                            ? Colors.blue[50]
                            : (book[index].genre == "reading")
                            ? Colors.yellow[50]
                            : Colors.green[50],
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Text(book[index].id.toString()),
                        ),
                        title: Text(
                          book[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(book[index].author),
                            Text('Rating: ${book[index].rating}'),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            providerFalse.deleteData(id: book[index].id);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          providerFalse.clearAll();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Book'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(controller: providerTrue.txtTitle, name: 'Title'),
                  SizedBox(height: 10),
                  MyTextField(
                      controller: providerTrue.txtAuthor, name: 'Author'),
                  SizedBox(height: 10),
                  MyTextField(controller: providerTrue.txtGenre, name: 'Genre'),
                  SizedBox(height: 10),
                  MyTextField(controller: providerTrue.txtRating, name: 'Rating'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    providerTrue.id = providerTrue.bookList.length + 1;
                    providerFalse.insertDatabase(
                      id: providerTrue.id,
                      title: providerTrue.txtTitle.text,
                      author: providerTrue.txtAuthor.text,
                      genre: providerTrue.txtGenre.text,
                      rating: providerTrue.txtRating.text,
                    );
                    Navigator.pop(context);
                    providerFalse.clearAll();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
