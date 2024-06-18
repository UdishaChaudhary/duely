import 'dart:ffi';

import 'package:duely/pages/add_task_page.dart';
import 'package:duely/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:duely/components/task_clips.dart';
import "package:http/http.dart" as http;
import "dart:convert";

/*
class Task {
  final String priority;
  final DateTime taskDate;
  final String taskDesc;
  final String taskName;

  Task({
    required this.priority,
    required this.taskDate,
    required this.taskDesc,
    required this.taskName,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      priority: map['priority'],
      taskDate: DateTime.parse(map['task-date']),
      taskDesc: map['task-desc'],
      taskName: map['task-name'],
    );
  }
}*/

class MyHompage extends StatefulWidget {
  MyHompage({super.key});

  @override
  State<MyHompage> createState() => _MyHompageState();
}

class _MyHompageState extends State<MyHompage> {
  final user = FirebaseAuth.instance.currentUser!;

  // Get the current user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Syntax for list : Type of a List (Array): List<TYPE_OF_MEMBER>
  // Syntax for dictionaries : (Key-Values): Map<Key_TYPE, VALUE_TYPE>
  List<Map<String, dynamic>> criticalTasks = [];
  List<Map<String, dynamic>> mediumTasks = [];
  List<Map<String, dynamic>> lowTasks = [];

  Future<void> fetchReminder() async {
    if (currentUser == null) {
      print('No user is currently signed in.');
      return;
    }

    final email = currentUser!.email;

    if (email == null) {
      print('User email is null.');
      return;
    }

    final response = await http.post(
      Uri.parse('https://duely-epp4.onrender.com/homepage'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Ensure each task is a Map<String, dynamic>
      List<Map<String, dynamic>> tasks =
          List<Map<String, dynamic>>.from(data['tasks']);

      criticalTasks.addAll(tasks
          .where((task) => task['priority'] == 'Critical')
          .map((task) => {
                'priority': task['priority'],
                'task-date': DateTime.parse(task['task-date']),
                'task-desc': task['task-desc'],
                'task-name': task['task-name'],
              })
          .toList());

      mediumTasks.addAll(tasks
          .where((task) => task['priority'] == 'Medium')
          .map((task) => {
                'priority': task['priority'],
                'task-date': DateTime.parse(task['task-date']),
                'task-desc': task['task-desc'],
                'task-name': task['task-name'],
              })
          .toList());

      lowTasks.addAll(tasks
          .where((task) => task['priority'] == 'Low')
          .map((task) => {
                'priority': task['priority'],
                'task-date': DateTime.parse(task['task-date']),
                'task-desc': task['task-desc'],
                'task-name': task['task-name'],
              })
          .toList());

    } else {
      print('Failed to fetch reminders: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchReminder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 108, 135, 95),
        /* leading: IconButton(
        icon: const Icon(Icons.add_alert, color: Colors.white),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return AddTask();
          }));
        },
      ),*/
        title: Text(
          'Duely',
          style: GoogleFonts.calligraffitti(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 194, 209, 188),
          child: ListView(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.home,
                  size: 45,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Homepage',
                    style: TextStyle(fontSize: 14, color: Color(0xFF323030))),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHompage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Task',
                    style: TextStyle(fontSize: 14, color: Color(0xFF323030))),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return AddTask();
                  }));
                },
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Logout',
                    style: TextStyle(fontSize: 14, color: Color(0xFF323030))),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
          child: Column(
            // this column is for covering all 3 section
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  if (criticalTasks.isNotEmpty)
                    Container(
                      // Container for whole top section (inivisible box)
                      color: Color.fromARGB(0, 255, 255, 255),
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                                      color: Color.fromARGB(164, 140, 152, 28),
                                      width: 1.4,),
                          
                        ),
                        padding: const EdgeInsets.only(top: 5.0, bottom: 13.0),
                        child: Column(
                          children: criticalTasks.map((task) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, left: 5, right: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(125, 169, 201, 158),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        task['task-name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        task['task-desc'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Due: ${task['task-date'].toLocal().toString().split(' ')[0]}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  Container(
                    width: 200, // or any width you prefer
                    height: 28, // or any height you prefer
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 71, 117, 69),
                    ),
                    child: Text(
                      'Today\'s Top Reminders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Divider(
                        color: Colors.black,
                        thickness: 0.2,
                        endIndent: 0,
                        indent: 10,
                      ),
                    ),
                    Container(
                      width: 180, // or any width you prefer
                      height: 28, // or any height you prefer
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 71, 117, 69),
                      ),
                      child: Text(
                        'Medium Priority',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.roboto().fontFamily,

                        ),
                      ),
                    ),
                    Flexible(
                      child: Divider(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        thickness: 0.2,
                        endIndent: 10,
                      ),
                    ),
                  ],
                ),
              ),
              if (mediumTasks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: mediumTasks.map((task) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TaskClips(
                            taskDesc: task['task-desc'],
                            taskName: task['task-name'],
                            taskDate: task['task-date']
                                .toLocal()
                                .toString()
                                .split(' ')[0],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Divider(
                        color: Colors.black,
                        thickness: 0.2,
                        endIndent: 0,
                        indent: 10,
                      ),
                    ),
                    Container(
                      width: 180, // or any width you prefer
                      height: 28, // or any height you prefer
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 71, 117, 69),
                      ),
                      child: Text(
                        'Low Priority',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.roboto().fontFamily,

                        ),
                      ),
                    ),
                    Flexible(
                      child: Divider(
                        color: Colors.black,
                        thickness: 0.2,
                        endIndent: 10,
                      ),
                    ),
                  ],
                ),
              ),
              if (lowTasks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: lowTasks.map((task) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TaskClips(
                            taskDesc: task['task-desc'],
                            taskName: task['task-name'],
                            taskDate: task['task-date']
                                .toLocal()
                                .toString()
                                .split(' ')[0],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
