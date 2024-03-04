import 'package:duely/components/MyTextField.dart';
import 'package:duely/components/button.dart';
import 'signUp.dart';
import 'package:flutter/material.dart'; // gives access to pre-defined widgets including

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void login(){}

  void signn(BuildContext ctx){
    Navigator.of(ctx).push(MaterialPageRoute(builder:(_){
      return signUpPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 144, 116, 219),
          title: Text("Duely",
            style: TextStyle(
              color: Colors.white,
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
                onTap: login,
              ),


              const SizedBox(height: 50),

              Text(
                'Sign up if you are new',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),

              const SizedBox(height: 25),

              MyButton(
                buttonName: "Sign up",
                onTap: (){signn(context);},
              ),


            ],
          ),
        )));
  }
}
