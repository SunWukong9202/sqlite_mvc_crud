import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'database_helper.dart';
import 'models/task_model.dart';

TaskController controller = TaskController();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Task.db = await DataBaseHelper.getDB();
  await TaskController.tasks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLITE MVC DEMO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: controller.buildView(context),
    );
  }
}
