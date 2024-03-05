import 'package:duely/pages/add_task_page.dart';
import 'package:flutter/material.dart'; // gives access to pre-defined widgets including
import 'pages/homepage.dart';
import 'pages/login.dart';

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
      title: "Duely",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
        scaffoldBackgroundColor: Color.fromARGB(255, 248, 248, 248),
        
      ),
    
      debugShowCheckedModeBanner: false,
      home: AddTask() 
      //MyHompeage()
      //LoginPage(),
      //signUpPage()
    );
  }
}
