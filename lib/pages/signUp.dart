import 'package:duely/components/button.dart';
import 'package:duely/components/MyTextField.dart';
import 'package:flutter/material.dart'; // gives access to pre-defined widgets including

class signUpPage extends StatelessWidget {
  signUpPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signup() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 131, 119, 165),
          title: Text("Duely",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Script",
              fontSize: 30,
            ),
          )
        ),
        backgroundColor: Color.fromARGB(255, 242, 234, 249),
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
                'Sign up to create an account',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),

              const SizedBox(height: 25),
              // username
              MyTextField(
                controller: usernameController,
                hintText: 'Enter your full name',
                obscureText: false,
              ),

              const SizedBox(height: 25),
              //email
              MyTextField(
                controller: passwordController,
                hintText: 'Enter your email',
                obscureText: false,
              ),

              const SizedBox(height: 25),
              //password
              MyTextField(
                controller: passwordController,
                hintText: 'Enter a password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              MyButton(
                buttonName: "Sign up",
                onTap: signup,
              ),
            ],
          ),
        )));
  }
}
