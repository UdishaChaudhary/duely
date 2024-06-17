import 'package:duely/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_page.dart';
import 'package:flutter/material.dart';


class MainPage extends StatelessWidget{
  const MainPage({Key? key}) : super(key:key);


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return MyHompage();
          } 
          else {
            return AuthPage();
          }
        },
      ),
    );
  }
}