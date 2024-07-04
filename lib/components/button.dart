import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonName;
  final Function()? onTap;

  MyButton({Key? key, required this.buttonName, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 108, 135, 95), // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25), // Horizontal padding
          minimumSize: Size(200, 50), // Full width and fixed height
          elevation: 4, // Adjust the elevation here
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
