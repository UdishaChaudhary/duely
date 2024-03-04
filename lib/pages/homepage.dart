import 'package:flutter/material.dart'; // gives access to pre-defined widgets including


class MyHompeage extends StatelessWidget{
  MyHompeage({super.key});



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

    );
  }
}