
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Service/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    // var providerTrue = Provider.of<BookProvider>(context);
    // var providerFalse = Provider.of<BookProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SignIn'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0,right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             TextField(
               decoration: InputDecoration(
                 hintText: "enter your email",
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(15),
                 )
               ),
             ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  hintText: "enter your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextButton(onPressed: () {
                Navigator.of(context).pushNamed("/signup");
              }, child: Text("you don't have account ? SignUp"),),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  AuthService.authService.signInWithGoogle();
                  Navigator.of(context).pushNamed('/home');
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    image: DecorationImage(fit: BoxFit.cover,image: NetworkImage('https://banner2.cleanpng.com/20181108/vqy/kisspng-youtube-google-logo-google-images-google-account-consulting-crm-the-1-recommended-crm-for-g-suite-1713925083723.webp'),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}