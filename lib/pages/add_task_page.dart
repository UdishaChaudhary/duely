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
  String _dropdownValue = "High_priority";
  final taskName = TextEditingController();
  final description = TextEditingController();

  void submitReminder(BuildContext ctx) {
    final reminder_details = {
      "task-name": taskName.text.trim(),
      "task-desc": description.text.trim(),
      "task-date": _dateTime
    };

    print(reminder_details);
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
              'Create a new reminder',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 28,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align children to the start (left)
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
                  hintText: 'Give a title to this reminder',
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
                  hintText: 'Description',
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
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Text(
                        '${_dateTime.day}-${_dateTime.month}-${_dateTime.year}',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 39, 39, 39),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),

                      const SizedBox(width: 30),

                      MaterialButton(
                        onPressed: () {
                          _showDatePicker(context);
                        },
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Choose Date"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                  child: Text(
                    'Select Priority',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),

              
                



                MyButton(
                  buttonName: "Done",
                  onTap: () {
                    submitReminder(context);
                  },
                ),
              ],
            ),
          ],
        )));
  }
}
