import 'package:advance_final_exam_2/view/screens/home_page.dart';
import 'package:advance_final_exam_2/view/screens/sign_in.dart';
import 'package:advance_final_exam_2/view/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       routes: {
        '/' : (context) => HomePage(),
        '/signup' : (context) => SignUp(),
        // '/home' : (context) => HomePage(),
       },
    );
  }
}

