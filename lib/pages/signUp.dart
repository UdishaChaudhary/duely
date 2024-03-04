import 'package:duely/components/button.dart';
import 'package:duely/components/MyTextField.dart';
import 'package:duely/pages/login.dart';
import 'package:flutter/material.dart'; // gives access to pre-defined widgets including

class signUpPage extends StatelessWidget {
  signUpPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signup(BuildContext ctx) {
    final signup_details = {
      "username": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };

    print(signup_details);

    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 105, 49, 162),
            title: Text(
              "Duely",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Script",
                fontSize: 30,
              ),
            )),
        body: SafeArea(
            child: Center(
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
                controller: usernameController,
                hintText: 'Enter your full name',
                obscureText: false,
              ),

              const SizedBox(height: 25),
              // email
              MyTextField(
                controller: emailController,
                hintText: 'Enter a username or email',
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
                onTap: () {
                  signup(context);
                },
              ),
            ],
          ),
        )));
  }
}
