import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        title: Text('Home Page',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )
              ),
            ),
          )
          
        ],
      ),
      floatingActionButton:FloatingActionButton(onPressed: () {
        showDialog(context: context, builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add Book",style: TextStyle(fontSize: 20),),
                SizedBox(height: 5,),
                TextField(
                  decoration: InputDecoration(
                    label: Text("Book Title"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                ),
                SizedBox(height: 5,),
                TextField(
                  decoration: InputDecoration(
                      label: Text("Author"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),
                SizedBox(height: 5,),
                TextField(
                  decoration: InputDecoration(
                      label: Text("Statu"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 150,),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text("Cancel"),),
                    TextButton(onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    }, child: Text("Save"),),
                  ],
                ),
              ],
            ),
          ),
        ),);
      },) ,
    );
  }
}
