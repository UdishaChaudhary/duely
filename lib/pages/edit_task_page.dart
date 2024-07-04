import "package:duely/components/button.dart";
import "package:duely/components/my_text_field.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:duely/pages/homepage.dart';
import "package:http/http.dart" as http;
import 'package:google_fonts/google_fonts.dart';
import "dart:convert";

class EditTask extends StatefulWidget {
  final String taskDesc;
  final String taskName;
  final String priority;
  final String taskDate;

  EditTask({
    super.key,
    required this.taskDesc,
    required this.taskName,
    required this.priority,
    required this.taskDate,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  String _dropdownValue = "";
  final taskName = TextEditingController();
  final description = TextEditingController();
  final dateController =
      TextEditingController(); // Controller for the date TextField

  // Get the current user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  String _dateTime = "";

  @override
  void initState() {
    super.initState();
    taskName.text = widget.taskName;
    description.text = widget.taskDesc;
    _dropdownValue = widget.priority;
    _dateTime = widget.taskDate;
  }

  Future<bool> editReminder() async {
    print(currentUser);
    final reminderDetails = {
      "user_id": currentUser?.email,
      "task-name": taskName.text.trim(),
      "task-desc": description.text.trim(),
      "task-date": _dateTime,
      "priority": _dropdownValue // Convert DateTime to ISO 8601 string
    };

    final response = await http.post(
      Uri.parse('https://duely-epp4.onrender.com/edit-task'),
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

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        DateTime getdate =
            value!; //The exclamation mark ! is the null assertion operator in Dart.
        //value! asserts that value is not null.
        _dateTime =
            "${getdate.day}-${getdate.month}-${getdate.year}"; // Update the controller with the selected date
        dateController.text = _dateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 246, 242),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 108, 135, 95),
        title: Text(
          "Duely",
          style: GoogleFonts.calligraffitti(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'Edit this reminder',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                  child: Text(
                    'Title',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                MyTextField(
                  controller: taskName,
                  hintText: 'Enter task name',
                  obscureText: false,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                  child: Text(
                    'Description (Optional)',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                MyTextField(
                  controller: description,
                  hintText: 'Enter task description',
                  obscureText: false,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                  child: Text(
                    'Final Date (dd-mm-yy)',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
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
                                      const Color.fromARGB(255, 217, 217, 217)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 217, 217, 217)),
                            ),
                            labelText: dateController.text.isEmpty
                                ? widget.taskDate
                                : dateController.text,
                            filled: true,
                          ),
                        ),
                      )),
                      SizedBox(
                          width:
                              10), // Add space between the TextField and the button (if needed)
                      SizedBox(
                        width: 70, // Adjust the width of the calendar container
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => _showDatePicker(),
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
                ),
                const SizedBox(height: 40),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 5),
                  child: Container(
                    width: 200,
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _dropdownValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        onChanged: (newValue) {
                          setState(() {
                            _dropdownValue = newValue!;
                          });
                        },
                        items: <String>['Critical', 'Medium', 'Low']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  alignment: Alignment.center,
                  child: Column(children: [ 
                  MyButton(
                    buttonName: "Save",
                    onTap: () async {
                      bool success = await editReminder();
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Reminder added successfully')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to add reminder')));
                      }
                    }),
                    const SizedBox(height: 20),
                    MyButton(
                    buttonName: "Delete",
                    onTap: () async {
                      bool success = await editReminder();
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Reminder added successfully')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to add reminder')));
                      }
                    }),
                    
                ],))
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
