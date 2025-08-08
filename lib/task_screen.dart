import 'package:flutter/material.dart';
import 'package:task_manager_ui/model/task_data.dart';
import 'package:task_manager_ui/widget/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<Task> demoTasks = [
    Task(
      id: 'Order-1043',
      title: 'Arrange Pickup',
      assignee: 'Sandhya',
      priority: 'High',
      status: TaskStatus.Started,
      startDate: DateTime(2025, 8, 10),
      dueDate: DateTime(2025, 8, 7),
    ),
    Task(
      id: 'Entity-2559',
      title: 'Adhoc Task',
      assignee: 'Arman',
      priority: 'Medium',
      status: TaskStatus.Started,
      startDate: DateTime(2025, 8, 12),
      dueDate: DateTime(2025, 8, 7),
    ),
    Task(
      id: 'Order-1020',
      title: 'Collect Payment',
      assignee: 'Sandhya',
      priority: 'High',
      status: TaskStatus.Started,
      startDate: DateTime(2025, 8, 15),
      dueDate: DateTime(2025, 8, 7),
    ),
    Task(
      id: 'Order-194',
      title: 'Arrange Delivery',
      assignee: 'Prashant',
      priority: 'Low',
      status: TaskStatus.Completed,
      startDate: DateTime(2025, 8, 20),
      dueDate: DateTime(2025, 8, 21),
    ),
    Task(
      id: 'Entity-2184',
      title: 'Share Company Profile',
      assignee: 'Asif Khan K',
      priority: 'Medium',
      status: TaskStatus.Completed,
      startDate: DateTime(2025, 8, 22),
      dueDate: DateTime(2025, 8, 23),
    ),
    Task(
      id: 'Entity-472',
      title: 'Add Followup',
      assignee: 'Avik',
      priority: 'Medium',
      status: TaskStatus.Completed,
      startDate: DateTime(2025, 8, 25),
      dueDate: DateTime(2025, 8, 26),
    ),
    Task(
      id: 'Enquiry-3563',
      title: 'Convert Enquiry',
      assignee: 'Prashant',
      priority: 'Low',
      status: TaskStatus.NotStarted,
      startDate: DateTime(2025, 8, 28),
      dueDate: DateTime(2025, 8, 30),
    ),
    Task(
      id: 'Order-176',
      title: 'Arrange Pickup',
      assignee: 'Prashant',
      priority: 'High',
      status: TaskStatus.NotStarted,
      startDate: DateTime(2025, 9, 1),
      dueDate: DateTime(2025, 9, 2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Task> sortedTasks = List.from(demoTasks);
    sortedTasks.sort((a, b) => a.status.index.compareTo(b.status.index));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: sortedTasks.length,
            itemBuilder: (context, value) => buildTaskCard(
              sortedTasks[value],
              onStartTask: () {
                setState(() {
                  demoTasks[value].status = TaskStatus.Started;
                  demoTasks[value].startDate = DateTime.now();
                });
              },
              onMarkComplete: () {
                setState(() {
                  demoTasks[value].status = TaskStatus.Completed;
                });
              },
              onEditStart: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: demoTasks[value].startDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                setState(() {
                  demoTasks[value].startDate =
                      picked ?? demoTasks[value].startDate;
                });
              },
              onEditDeadline: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: demoTasks[value].dueDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                setState(() {
                  demoTasks[value].dueDate = picked ?? demoTasks[value].dueDate;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
