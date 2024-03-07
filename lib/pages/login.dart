import 'package:duely/components/my_text_field.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:duely/components/button.dart';
import 'package:duely/pages/sign_up.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart'; // gives access to pre-defined widgets including


class LoginPage extends StatefulWidget {

  final VoidCallback showSignupPage;
  const LoginPage({
    Key? key, required this.showSignupPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future logIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }



  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 105, 49, 162),
            title: Text(
              "Duely",
              style: GoogleFonts.calligraffitti()
            )),
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),

              //logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              Text(
                'Log in',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),

              const SizedBox(height: 25),
              // username
              MyTextField(
                controller: emailController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 25),
              //password
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              MyButton(
                buttonName: "Log in",
                onTap: () {
                  logIn();
                },
              ),

              const SizedBox(height: 50),

              Text(
                'Sign up if you are new',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),

              const SizedBox(height: 25),

              MyButton(
                buttonName: "Sign up",
                onTap: widget.showSignupPage,
                
              ),
            ],
          ),
        )));
  }
}
