import "package:duely/components/button.dart";
import "package:duely/components/my_text_field.dart";
import "package:flutter/material.dart";

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _dateTime = DateTime.now();

  final taskName = TextEditingController();
  final description = TextEditingController();

  void submit_reminder(BuildContext ctx) {
    final reminder_details = {
      "task-name": taskName,
      "task-desc": description,
      "task-date": _dateTime
    };
  }

  void _showDatePicker(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2030))
        .then(
      (value) => {_dateTime = value!},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is options')));
              },
            )
          ],
        ),
        body: Center(
            child: Column(
          children: [
            Text(
              'Create Reminder',
              style: TextStyle(
                  color: const Color.fromARGB(255, 39, 39, 39),
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Align children to the start (left)
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  MyTextField(
                    controller: taskName,
                    hintText: 'Give a title to this reminder',
                    obscureText: false,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Description (Optional)',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  MyTextField(
                    controller: description,
                    hintText: 'Description',
                    obscureText: false,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Final Date (dd-mm-yy)',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${_dateTime.day}-${_dateTime.month}-${_dateTime.year}',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 39, 39, 39),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      MaterialButton(
                        onPressed: () {
                          _showDatePicker(context);
                        },
                        color: Colors.green,
                        child: Text("Choose Date"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Select Priority',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),
                  MyButton(
                    buttonName: "Submit",
                    onTap: () {
                      submit_reminder(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
