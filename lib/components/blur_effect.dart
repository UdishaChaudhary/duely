import 'package:flutter/material.dart';

class taskTabClick extends StatefulWidget {
  
  const taskTabClick({ 
    super.key
  });

  @override
  State<taskTabClick> createState() => _taskTabClickState();
}

class _taskTabClickState extends State<taskTabClick> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(243, 96, 96, 109),
                Color.fromARGB(132, 207, 203, 225),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      );
      
    }
}