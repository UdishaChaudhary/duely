import 'package:flutter/material.dart'; // gives access to pre-defined widgets including
import 'pages/login.dart';
import 'pages/signUp.dart';

void main() {
  runApp(
      MyApp()); //runapp is a global function that takes a signle widget in the argument
}

class MyApp extends StatelessWidget {
  //stateless widget means it doesn't have any data it just paints the screen
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //build method returns a widget and is called anytime flutter needs to rebuild the UI
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: signUpPage()
      //LoginPage(), 
    );
  }
}
