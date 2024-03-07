import 'package:duely/components/button.dart';
import 'package:duely/components/my_text_field.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart'; // gives access to pre-defined widgets including
import 'package:google_fonts/google_fonts.dart';

class signUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const signUpPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confrimController = TextEditingController();

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confrimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 145, 102, 188),
            title: Text(
              "Duely",
              style: GoogleFonts.calligraffitti(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            )),
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),

                //logo
                const Icon(
                  Icons.person,
                  size: 100,
                ),

                const SizedBox(height: 50),

                Text(
                  'Sign up to create an account',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),

                const SizedBox(height: 25),
                // username
                MyTextField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  obscureText: false,
                ),

                const SizedBox(height: 25),
                // email
                MyTextField(
                  controller: passwordController,
                  hintText: 'Enter a password',
                  obscureText: false,
                ),

                const SizedBox(height: 25),
                //password
                MyTextField(
                  controller: confrimController,
                  hintText: 'Confirm your password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                MyButton(
                  buttonName: "Sign up",
                  onTap: () {
                    signUp();
                  },
                ),

                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member? ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
