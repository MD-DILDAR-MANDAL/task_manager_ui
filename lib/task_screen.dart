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
      id: 'T-001',
      title: 'Design Login Screen',
      assignee: 'Alice',
      priority: 'High',
      status: TaskStatus.NotStarted,
      startDate: DateTime(2025, 8, 8),
      dueDate: DateTime(2025, 8, 10),
    ),
    Task(
      id: 'T-002',
      title: 'Set Up Backend API',
      assignee: 'Bob',
      priority: 'Medium',
      status: TaskStatus.Started,
      startDate: DateTime(2025, 8, 7),
      dueDate: DateTime(2025, 8, 11),
    ),
    Task(
      id: 'T-003',
      title: 'Write Unit Tests',
      assignee: 'Charlie',
      priority: 'Low',
      status: TaskStatus.Completed,
      startDate: DateTime(2025, 8, 5),
      dueDate: DateTime(2025, 8, 8),
    ),
    Task(
      id: 'T-004',
      title: 'Create Splash Screen',
      assignee: 'Dana',
      priority: 'Medium',
      status: TaskStatus.NotStarted,
      startDate: DateTime(2025, 8, 9),
      dueDate: DateTime(2025, 8, 13),
    ),
    Task(
      id: 'T-005',
      title: 'Integrate Firebase',
      assignee: 'Eve',
      priority: 'High',
      status: TaskStatus.Started,
      startDate: DateTime(2025, 8, 6),
      dueDate: DateTime(2025, 8, 10),
    ),

    Task(
      id: 'T-006',
      title: 'Integrate Firebase',
      assignee: 'Eve',
      priority: 'High',
      status: TaskStatus.Started,
      startDate: DateTime(2025, 8, 6),
      dueDate: DateTime(2025, 8, 7),
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
            itemBuilder: (context, value) => buildTaskCard(sortedTasks[value]),
          ),
        ),
      ),
    );
  }
}
