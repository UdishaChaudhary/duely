import 'package:flutter/material.dart';

class taskTab extends StatelessWidget {

  taskTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                      padding: const EdgeInsets.all(100),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 240, 120, 120),
                      ),
                      
                      );
  }

}