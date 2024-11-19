import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/Attendance_provider.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     var providerTrue = Provider.of<AttendanceProvider>(context);
     var providerFalse = Provider.of<AttendanceProvider>(context, listen: false);
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
                Text("Student Attendance",style: TextStyle(fontSize: 20),),
                SizedBox(height: 7,),
                TextField(
                  controller: providerTrue.txtname,
                  decoration: InputDecoration(
                      label: Text("Student Name"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: providerTrue.txtdate,
                  decoration: InputDecoration(
                      label: Text("Date"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: providerTrue.txtpresent,
                  decoration: InputDecoration(
                      label: Text("Present"),
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
