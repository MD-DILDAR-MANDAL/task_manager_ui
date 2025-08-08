import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:task_manager_ui/model/task_data.dart';

Widget buildTaskCard(Task task) {
  Color? statusColor;
  Widget? actionButton;
  Widget? editIcon;
  String statusLabel = '';

  if (task.status == TaskStatus.NotStarted) {
    statusColor = Colors.orange;
    actionButton = ElevatedButton(onPressed: () {}, child: Text("Start Task"));
    editIcon = IconButton(icon: Icon(Icons.edit), onPressed: () {});
    statusLabel = 'Due in ${daysUntil(task.dueDate)} days';
  } 
  else if (task.status == TaskStatus.Started) {
    statusColor = task.dueDate.isBefore(DateTime.now())
        ? Colors.red
        : Colors.green;
    actionButton = ElevatedButton(
      onPressed: () {},
      child: Text("Mark as Complete"),
    );
    statusLabel = task.dueDate.isBefore(DateTime.now())
        ? 'Overdue'
        : 'In Progress';
  } 
  else {
    statusColor = Colors.green;
    statusLabel = 'Completed: ${formatDate(task.dueDate)}';
  }

  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(task.id, style: TextStyle(color: Colors.blue)),
            if (editIcon != null) editIcon,
          ],
        ),
        Text(task.title),
        Text('Assigned to: ${task.assignee}'),
        Text('Priority: ${task.priority}', style: TextStyle(color: Colors.red)),
        Text(statusLabel, style: TextStyle(color: statusColor)),
        if (actionButton != null) actionButton,
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
  return DateFormat.yMMMd().format(date);
}
