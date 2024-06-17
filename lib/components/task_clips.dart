import 'package:flutter/material.dart';

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
            color: _isTaskTabPressed ? Colors.grey : Color.fromARGB(255, 255, 255, 255),
            width: 1,
          ),
        ),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: _isTaskTabPressed
                ? Colors.grey
                : Color.fromARGB(255, 218, 207, 238),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<int>(
                  icon: Icon(Icons.more_vert, color: Colors.black, size: 30),
                  onSelected: (item) => onSelected(context, item),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(value: 0, child: Text('Edit')),
                    PopupMenuItem<int>(value: 1, child: Text('Delete')),
                  ],
                ),
              ),
              Column(
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
                  /*SizedBox(height: 8),
                  Text(
                    widget.taskDesc,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),*/
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
            ],
          ),
        ),
      ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        // Handle edit action
        break;
      case 1:
        // Handle delete action
        break;
    }
  }
}
