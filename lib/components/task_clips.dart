import 'package:flutter/material.dart';
import 'dart:ui';
import "package:duely/pages/edit_task_page.dart";
import "package:duely/pages/homepage.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskClips extends StatefulWidget {
  final String taskDesc;
  final String taskName;
  final String priority;
  final String taskId;
  final String taskDate;
  final String currentUser;
  final String taskStatus;

  const TaskClips({
    super.key,
    required this.taskDesc,
    required this.taskName,
    required this.priority,
    required this.taskId,
    required this.taskDate,
    required this.currentUser,
    required this.taskStatus,
  });

  @override
  State<TaskClips> createState() => _TaskClipsState();
}

class _TaskClipsState extends State<TaskClips> {
  bool _isTaskTabPressed = false;
  final String markDoneUrl = "http://127.0.0.1:5000/mark_done"; // Fixed URL

  Future<bool> markReminder() async {
    final reminderDetails = {
      'taskDesc': widget.taskDesc,
      'taskName': widget.taskName,
      'priority': widget.priority,
      'taskDate': widget.taskDate,
      'taskId': widget.taskId,
      'email': widget.currentUser,
      'taskStatus': widget.taskStatus,
    };

    final response = await http.post(
      Uri.parse(markDoneUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(reminderDetails),
    );
    print(reminderDetails);

    if (response.statusCode == 200) {
      print('Reminder marked as done');
      return true;
    } else {
      print('Failed to mark reminder as done');
      return false;
    }
  }

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
                : const Color.fromARGB(255, 255, 255, 255),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                width: 200,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(159, 169, 213, 202),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.taskName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Due: ${widget.taskDate}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    if (widget.taskStatus == 'done') ...[
                      const SizedBox(height: 8),
                      const Text(
                        'STATUS: DONE',
                        style: TextStyle(
                          color: Color.fromARGB(255, 76, 175, 91),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 8),
                      const Text(
                        'STATUS: PENDING',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 87, 34),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (_isTaskTabPressed)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: Container(
                    width: 200,
                    decoration: const BoxDecoration(
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
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTask(
                                      taskDesc: widget.taskDesc,
                                      taskName: widget.taskName,
                                      priority: widget.priority,
                                      taskDate: widget.taskDate,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const Text("|",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            TextButton(
                              onPressed: () {
                                markReminder();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHompage(),
                                ),);
                              },
                              child: const Text(
                                "Task Done",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
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
