import 'package:flutter/material.dart';
import 'package:duely/pages/edit_task_page.dart';
import 'dart:ui';

class TopTaskTab extends StatefulWidget {
  final Map<String, dynamic> task;

  TopTaskTab({super.key, required this.task});

  @override
  _TopTaskTabState createState() => _TopTaskTabState();
}

class _TopTaskTabState extends State<TopTaskTab> {
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: _isTaskTabPressed
                      ? Color.fromARGB(125, 169, 201, 158)
                      : Color.fromARGB(255, 255, 255, 255),
                  width: 1,
                ),
                color: Color.fromARGB(125, 169, 201, 158),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.task['task-name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.task['task-desc'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Due: ${widget.task['task-date'].toLocal().toString().split(' ')[0]}',
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
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
                                    taskDesc: widget.task['task-desc'],
                                    taskName: widget.task['task-name'],
                                    priority: widget.task['priority'],
                                    taskDate: widget.task['task-date'].toIso8601String(),
                                  ),
                                ),
                              );
                            },
                            child: Text("Edit",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          Text("|",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          TextButton(
                            onPressed: () {
                              // Add the task completion logic here
                            },
                            child: Text(
                              "Task Done",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
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
    );
  }
}


      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
      //     child: Column(
      //       // this column is for covering all 3 section
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Stack(
      //           alignment: AlignmentDirectional.topCenter,
      //           children: [
      //             if (criticalTasks.isNotEmpty)
      //               Container(
      //                 // Container for whole top section (inivisible box)
      //                 color: Color.fromARGB(0, 255, 255, 255),
      //                 padding: const EdgeInsets.only(top: 12.0),
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                     color: Color.fromARGB(255, 255, 255, 255),
      //                     borderRadius: BorderRadius.circular(15),
      //                     border: Border.all(
      //                       color: Color.fromARGB(164, 140, 152, 28),
      //                       width: 1.4,
      //                     ),
      //                   ),
      //                   padding: const EdgeInsets.only(top: 5.0, bottom: 13.0),
      //                   child: Column(
      //                     children: criticalTasks.map((task) {
      //                       return Padding(
      //                         padding: const EdgeInsets.only(
      //                             top: 15.0, left: 5, right: 5),
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(15),
      //                           child: Container(
      //                             width: double.infinity,
      //                             decoration: BoxDecoration(
      //                               color: Color.fromARGB(125, 169, 201, 158),
      //                               borderRadius: BorderRadius.circular(15),
      //                             ),
      //                             padding: const EdgeInsets.all(16.0),
      //                             child: Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               mainAxisAlignment: MainAxisAlignment.center,
      //                               children: [
      //                                 Text(
      //                                   task['task-name'],
      //                                   style: TextStyle(
      //                                     color: Colors.black,
      //                                     fontSize: 16,
      //                                     fontWeight: FontWeight.bold,
      //                                   ),
      //                                 ),
      //                                 SizedBox(height: 8),
      //                                 Text(
      //                                   task['task-desc'],
      //                                   style: TextStyle(
      //                                     color: Colors.black,
      //                                     fontSize: 14,
      //                                   ),
      //                                 ),
      //                                 SizedBox(height: 8),
      //                                 Text(
      //                                   'Due: ${task['task-date'].toLocal().toString().split(' ')[0]}',
      //                                   style: TextStyle(
      //                                     color: Colors.black,
      //                                     fontSize: 14,
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       );
      //                     }).toList(),
      //                   ),
      //                 ),
      //               ),
      //             Container(
      //               width: 200, // or any width you prefer
      //               height: 28, // or any height you prefer
      //               alignment: Alignment.center,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(20),
      //                 color: Color.fromARGB(255, 138, 125, 78),
      //               ),
      //               child: Text(
      //                 'Today\'s Top Reminders',
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   fontFamily: GoogleFonts.roboto().fontFamily,
      //                   color: Colors.white,
      //                   fontSize: 15,
      //                   fontWeight: FontWeight.w500,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 20.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Flexible(
      //                 child: Divider(
      //                   color: Colors.black,
      //                   thickness: 0.2,
      //                   endIndent: 15,
      //                   indent: 10,
      //                 ),
      //               ),
      //               Text(
      //                 'MEDIUM PRIORITY',
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   color: const Color.fromARGB(255, 39, 39, 39),
      //                   fontSize: 15,
      //                   fontWeight: FontWeight.w500,
      //                   fontFamily: GoogleFonts.roboto().fontFamily,
      //                 ),
      //               ),
      //               Flexible(
      //                 child: Divider(
      //                   color: const Color.fromARGB(255, 0, 0, 0),
      //                   thickness: 0.2,
      //                   indent: 15,
      //                   endIndent: 10,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         if (mediumTasks.isNotEmpty)
      //           Padding(
      //             padding: const EdgeInsets.only(top: 20.0),
      //             child: SizedBox(
      //               height: 150,
      //               child: ListView(
      //                 scrollDirection: Axis.horizontal,
      //                 children: mediumTasks.map((task) {
      //                   return Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //                     child: TaskClips(
      //                       taskDesc: task['task-desc'],
      //                       taskName: task['task-name'],
      //                       priority: task['priority'],
      //                       taskDate: task['task-date']
      //                           .toLocal()
      //                           .toString()
      //                           .split(' ')[0],
      //                     ),
      //                   );
      //                 }).toList(),
      //               ),
      //             ),
      //           ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 25.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Flexible(
      //                 child: Divider(
      //                   color: Colors.black,
      //                   thickness: 0.2,
      //                   endIndent: 20,
      //                   indent: 10,
      //                 ),
      //               ),
      //               Text(
      //                 'LOW PRIORITY',
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   color: const Color.fromARGB(255, 39, 39, 39),
      //                   fontSize: 15,
      //                   fontWeight: FontWeight.w500,
      //                   fontFamily: GoogleFonts.roboto().fontFamily,
      //                 ),
      //               ),
      //               Flexible(
      //                 child: Divider(
      //                   color: Colors.black,
      //                   thickness: 0.2,
      //                   indent: 20,
      //                   endIndent: 10,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         if (lowTasks.isNotEmpty)
      //           Padding(
      //             padding: const EdgeInsets.only(top: 20.0),
      //             child: SizedBox(
      //               height: 150,
      //               child: ListView(
      //                 scrollDirection: Axis.horizontal,
      //                 children: lowTasks.map((task) {
      //                   return Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //                     child: TaskClips(
      //                       taskDesc: task['task-desc'],
      //                       taskName: task['task-name'],
      //                       priority: task['priority'],
      //                       taskDate: task['task-date']
      //                           .toLocal()
      //                           .toString()
      //                           .split(' ')[0],
      //                     ),
      //                   );
      //                 }).toList(),
      //               ),
      //             ),
      //           ),
      //       ],
      //     ),
      //   ),
      // ),
