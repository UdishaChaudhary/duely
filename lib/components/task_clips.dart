import 'package:flutter/material.dart';
import 'dart:ui'; // Add this line to import ImageFilter

class TaskClips extends StatefulWidget {
  final String taskDesc;
  final String taskName;
  final String taskDate;

  const TaskClips({
    Key? key,
    required this.taskDesc,
    required this.taskName,
    required this.taskDate,
  }) : super(key: key);

  @override
  State<TaskClips> createState() => _TaskClipsState();
}

class _TaskClipsState extends State<TaskClips> {
  bool _isTaskTabPressed = false;

  void taskTabPressed() {
    setState(() {
      _isTaskTabPressed = !_isTaskTabPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: taskTabPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isTaskTabPressed
                ? const Color.fromARGB(98, 158, 158, 158)
                : Color.fromARGB(255, 255, 255, 255),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Color.fromARGB(159, 169, 213, 202),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.taskName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Due: ${widget.taskDate}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (_isTaskTabPressed)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(0, 0, 0, 0),
                    ),
                  ),
                ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: _isTaskTabPressed
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, size: 35),
                              onPressed: () {
                                // Add your edit button functionality here
                              },
                            ),
                            SizedBox(width: 5),
                            IconButton(
                              icon: Icon(Icons.delete, size: 35),
                              onPressed: () {
                                // Add your edit button functionality here
                              },
                            ),
                          ],
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
