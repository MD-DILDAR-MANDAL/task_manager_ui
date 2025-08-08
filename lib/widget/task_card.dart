import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:task_manager_ui/model/task_data.dart';

Widget buildTaskCard(Task task) {
  Color? statusColor;
  Color? barColor;
  Widget? actionButton;
  Widget? editIcon;
  String statusLabel = '';
  String startStatus = '';

  if (task.status == TaskStatus.NotStarted) {
    statusColor = Colors.orange;
    actionButton = ElevatedButton(onPressed: () {}, child: Text("Start Task"));
    editIcon = IconButton(
      icon: Icon(Icons.edit_square, size: 18, color: Colors.grey),
      onPressed: () {},
    );
    statusLabel = 'Due in ${daysUntil(task.dueDate)} days';
    startStatus = "Start: ${formatDate(DateTime.now())}";
    barColor = Colors.grey;
  } else if (task.status == TaskStatus.Started) {
    statusColor = task.dueDate.isBefore(DateTime.now())
        ? Colors.red
        : Colors.green;
    barColor = Colors.blue;
    startStatus = "started: ${formatDate(task.startDate)}";
    actionButton = ElevatedButton(
      onPressed: () {},
      child: Text("Mark as Complete"),
    );
    editIcon = IconButton(
      icon: Icon(Icons.edit_square, size: 18, color: Colors.grey),
      onPressed: () {},
    );
    statusLabel = task.dueDate.isBefore(DateTime.now())
        ? 'Overdue - '
        : 'In Progress';
  } else {
    statusColor = Colors.green;
    statusLabel = 'Completed: ${formatDate(task.dueDate)}';
    startStatus = "started: ${formatDate(task.startDate)}";
    barColor = Colors.green;
  }

  String overDueTime = "";
  if (statusLabel == 'Overdue - ') {
    DateTime now = DateTime.now();
    Duration overdueDuration = now.difference(task.dueDate);
    int days = overdueDuration.inDays;
    int hours = overdueDuration.inHours % 24;
    int minutes = overdueDuration.inMinutes % 60;

    overDueTime = '${days}d ${hours}h ${minutes}m';
  }

  return Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    elevation: 0,
    child: Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (task.status == TaskStatus.NotStarted)
                DottedBorder(
                  options: CustomPathDottedBorderOptions(
                    color: barColor,
                    dashPattern: [26, 20],
                    strokeWidth: 8,
                    customPath: (size) => Path()
                      ..moveTo(0, 0)
                      ..relativeLineTo(0, size.height),
                  ),
                  child: Container(),
                )
              else
                Container(width: 6, color: barColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                task.id,
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 24, 95, 247),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.more_vert, size: 20),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Text(task.title),
                          Row(
                            children: [
                              Text('${task.assignee}'),
                              Text(
                                '  ${task.priority} priority',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$statusLabel$overDueTime",
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              if (editIcon != null) editIcon,
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                startStatus,
                                style: TextStyle(color: statusColor),
                              ),
                              if (editIcon != null) editIcon,
                            ],
                          ),
                          if (actionButton != null) actionButton,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1),
      ],
    ),
  );
}

int daysUntil(DateTime targetDate) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
  return target.difference(today).inDays;
}

String formatDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}
