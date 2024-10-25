import 'package:flutter/material.dart';

import '../../service/auth_service.dart';



class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter your Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 55),
                child: Row(
                  children: [
                    TextButton(onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    }, child: Text("You Don't Have Account?. SignUp")),
                  ],
                ),
              ),
              ElevatedButton(onPressed: () async {
                await AuthService.service.signInWithGoogle();
                Navigator.pushNamed(context, '/home');
              }, child: Text("Sign in"))
            ],
          ),
        ),
      ),
    );
  }
}
