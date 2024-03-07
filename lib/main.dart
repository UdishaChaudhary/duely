import 'package:duely/auth/main_page.dart';
import 'package:flutter/material.dart'; // gives access to pre-defined widgets including
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); //gives access to negative code

  await Firebase.initializeApp();

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
      home: MainPage()
    );
  }
}
