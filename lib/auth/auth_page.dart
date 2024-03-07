import 'package:duely/pages/login.dart';
import 'package:duely/pages/sign_up.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key?key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  // initially show a login page
  bool  showLoginPage = true;

  void toggleScreen(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(showLoginPage){
      return LoginPage(showSignupPage: toggleScreen);
    }
    else {
      return signUpPage(showLoginPage: toggleScreen);
    }
    
  }
}