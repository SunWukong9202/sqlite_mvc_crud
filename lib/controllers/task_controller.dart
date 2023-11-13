import 'package:flutter/material.dart';
import 'package:todo_app/views/tasks_view.dart';
import '../models/task_model.dart';

class TaskController {
  static List<Task> _tasks = [];

  Widget buildView(BuildContext context) {
    return TaskView(
      tasks: _tasks,
    );
  }

  static Future<void> insertTask(Task task) async {
    int id = await Task.insertTask(task);
    task.id = id;
  }

  static void deleteTask(int id) {
    Task.deleteTask(id);
  }

  static void updateTask(Task task) {
    Task.updateTask(task);
  }

  static void onToggleTask(Task task) {
    task.isCompleted = !task.isCompleted;
    updateTask(task);
  }

  static Future<void> tasks() async {
    _tasks = await Task.tasks();
  }
}
