import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // gives access to pre-defined widgets including

class MyHompeage extends StatelessWidget {
  MyHompeage({super.key});

  final tasks = ["ff", "ff", "ff", "cdhsbcd", "dhjbfk"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is home')));
              }),
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
        body: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start (left)
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Todays\'s top reminders!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding: const EdgeInsets.all(100),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 240, 120, 120),
                      ),
                      child: Text(
                        'task 1 ${tasks[index]}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            ),
          ],
        ));
  }
}
