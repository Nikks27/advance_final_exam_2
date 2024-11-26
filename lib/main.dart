import 'package:advance_final_exam_2/provider/Attendance_provider.dart';
import 'package:advance_final_exam_2/view/screen/home_page.dart';
import 'package:advance_final_exam_2/view/screen/signIn.dart';
import 'package:advance_final_exam_2/view/screen/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) =>BookProvider(), builder: (context, child) => const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SignIn(),
        // '/signup': (context) => Signup(),
        '/home': (context) => HomePage(),
        // '/home' : (context) => HomePage(),
      },
    );
  }
}