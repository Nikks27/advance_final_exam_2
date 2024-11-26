
import 'package:advance_final_exam_2/Service/auth_service.dart';
import 'package:advance_final_exam_2/view/screen/signIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modal/modal.dart';
import '../../provider/Attendance_provider.dart';
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
          TextButton(
              onPressed: () {
                providerFalse.cloudToLocally();
              },
              child: Text('Save Local')),
          TextButton(
              onPressed: () {
                List<BookModal> book = [];
                book = providerTrue.bookList
                    .map(
                      (e) => BookModal.fromMap(e),
                )
                    .toList();

                for (int i = 0; i < providerTrue.bookList.length; i++) {
                  providerFalse.booksAddInStore(
                      id: book[i].id,
                      title: book[i].title,
                      author: book[i].author,
                      status: book[i].status,
                      rating: book[i].rating
                  );
                }
              },
              child: Text('Back Up')),
          TextButton(onPressed: () async {
            await AuthService.authService.signOut();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn(),));
          }, child: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('Search'),
          ),
          Expanded(
            child: FutureBuilder(
              future: providerFalse.readData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<BookModal> book = [];
                  book = providerTrue.bookList
                      .map(
                        (e) => BookModal.fromMap(e),
                  )
                      .toList();
                  return ListView.builder(
                    itemCount: book.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        providerTrue.id = book[index].id;
                        providerTrue.txtTitle.text = book[index].title;
                        providerTrue.txtAuthor.text = book[index].author;
                        providerTrue.txtStatus.text = book[index].status;
                        providerTrue.txtRating.text = book[index].rating;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Update Contact'),
                            actions: [
                              MyTextField(
                                controller: providerTrue.txtTitle,
                                name: 'Title',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyTextField(
                                controller: providerTrue.txtAuthor,
                                name: 'Author',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyTextField(
                                controller: providerTrue.txtStatus,
                                name: 'Status',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyTextField(
                                controller: providerTrue.txtRating,
                                name: 'Rating',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      providerFalse.updateData(
                                          id: providerTrue.id,
                                          title: providerTrue.txtTitle.text,
                                          author: providerTrue.txtAuthor.text,
                                          status: providerTrue.txtStatus.text,
                                          rating: providerTrue.txtRating.text
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      leading: Text(book[index].id.toString()),
                      title: Text(
                        book[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(book[index].author),
                          Text('Rating: ${book[index].rating}')
                        ],
                      ),
                      trailing: GestureDetector(
                          onTap: () {
                            providerFalse.deleteData(id: book[index].id);
                          },
                          child: Icon(Icons.delete)),
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          providerFalse.clearAll();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Book'),
              actions: [
                MyTextField(
                  controller: providerTrue.txtTitle,
                  name: 'Title',
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: providerTrue.txtAuthor,
                  name: 'Author',
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: providerTrue.txtStatus,
                  name: 'Status',
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: providerTrue.txtRating,
                  name: 'Rating',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        providerTrue.id = providerTrue.bookList.length + 1;
                        providerFalse.insertDatabase(
                            id: providerTrue.id,
                            title: providerTrue.txtTitle.text,
                            author: providerTrue.txtAuthor.text,
                            status: providerTrue.txtStatus.text,
                            rating: providerTrue.txtRating.text,
                        );
                        Navigator.pop(context);
                        providerFalse.clearAll();
                      },
                      child: const Text('OK'),
                    ),
                  ],
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