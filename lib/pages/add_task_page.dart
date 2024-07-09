import "package:duely/components/button.dart";
import 'package:duely/pages/login.dart';
import "package:duely/components/my_text_field.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:duely/pages/homepage.dart';
import "package:http/http.dart" as http;
import 'package:google_fonts/google_fonts.dart';
import "dart:convert";

class AddTask extends StatefulWidget {
  AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _dateTime = DateTime.now();

  // final add_task_url = "https://duely-epp4.onrender.com/add-task";
  final add_task_url = "http://127.0.0.1:5000/add-task";

  String _dropdownValue = "";
  final taskName = TextEditingController();
  final description = TextEditingController();
  final dateController =
      TextEditingController(); // Controller for the date TextField
  List<TextEditingController> participantControllers = [];

  // Get the current user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Initialize the first participant text field controller
    participantControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    taskName.dispose();
    description.dispose();
    dateController.dispose();
    for (var controller in participantControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<bool> submitReminder() async {
    print(currentUser);
    final reminderDetails = {
      "user_id": currentUser?.email,
      "task-name": taskName.text.trim(),
      "task-desc": description.text.trim(),
      "task-date": _dateTime.toIso8601String(),
      "priority": _dropdownValue, // Convert DateTime to ISO 8601 string
      "participants": participantControllers
          .map((controller) => controller.text.trim())
          .toList(),
    };

    final response = await http.post(
      Uri.parse(add_task_url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(reminderDetails),
    );

    if (response.statusCode == 200) {
      print('Reminder added successfully');
      final responseData = jsonDecode(response.body);
      final task = responseData['task'];
      print('Success: $task');
      return true;
    } else {
      print('Failed to add reminder');
      return false;
    }
  }

  void _showDatePicker(BuildContext ctx) async {
    DateTime? pickedDate = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _dateTime = pickedDate;
        dateController.text =
            "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}"; // Update the controller with the selected date
      });
    }
  }

  void _addParticipantField() {
    setState(() {
      participantControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 246, 242),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 108, 135, 95),
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
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(showSignupPage: () {})),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set a new task',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Title',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  MyTextField(
                    controller: taskName,
                    hintText: 'Give a title to this reminder',
                    obscureText: false,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Description (Optional)',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  MyTextField(
                    controller: description,
                    hintText: 'Description',
                    obscureText: false,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Final Date (dd-mm-yy)',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          child: TextField(
                            controller: dateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 217, 217, 217),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 217, 217, 217),
                                ),
                              ),
                              labelText: 'Choose Date',
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 70,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => _showDatePicker(context),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.all(0),
                          ),
                          child: Icon(Icons.calendar_today),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, bottom: 5),
                    child: Container(
                      width: 200,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _dropdownValue.isEmpty ? null : _dropdownValue,
                          hint: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('Select Task Priority'),
                          ),
                          items: <String>['Critical', 'Medium', 'Low']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _dropdownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Add Participants (Optional)',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: participantControllers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: MyTextField(
                                    controller: participantControllers[index],
                                    hintText: 'Enter email',
                                    obscureText: false,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () {
                                    setState(() {
                                      participantControllers.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: _addParticipantField,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    alignment: Alignment.center,
                    child: MyButton(
                      buttonName: "Submit",
                      onTap: () async {
                        bool success = await submitReminder();
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Reminder added successfully'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to add reminder'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
