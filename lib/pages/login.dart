import 'package:duely/components/MyTextField.dart';
import 'package:duely/components/button.dart';
import 'signUp.dart';
import 'package:flutter/material.dart'; // gives access to pre-defined widgets including

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void login(BuildContext ctx) {
    final login_details = {
      "username": usernameController.text,
      "password": passwordController.text,
    };

    print(login_details);
  }

  void sign(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return signUpPage();
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
                controller: usernameController,
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
                  login(context);
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
                onTap: () {
                  sign(context);
                },
              ),
            ],
          ),
        )));
  }
}
