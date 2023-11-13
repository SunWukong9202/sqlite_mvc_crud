import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../controllers/task_controller.dart';
import './form_task.dart';
import './form_task_edit.dart';

class TaskView extends StatefulWidget {
  final List<Task> tasks;
  const TaskView({super.key, required this.tasks});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  ListView _tasksListView() {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        var task = widget.tasks[index];

        return ListTile(
          title: Text(task.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormEditTask(
                task: task,
                onTaskEdit: _onTaskEdit,
              ),
              InkWell(
                  onTap: () => _onTaskDelete(task),
                  child: const Icon(Icons.delete)),
              Checkbox(
                value: task.isCompleted,
                onChanged: (bool? value) {
                  _onTaskToggle(task);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _onTaskToggle(Task task) {
    setState(() {
      TaskController.onToggleTask(task);
    });
  }

  _onTaskEdit(Task task) {
    int i = widget.tasks.indexWhere((t) => t.id == task.id);
    if (i != -1) {
      widget.tasks[i] = task;
    }
    setState(() {
      TaskController.updateTask(task);
    });
  }

  _onTaskDelete(Task task) {
    setState(() {
      TaskController.deleteTask(task.id);
      widget.tasks.remove(task);
    });
  }

  _onTaskCreate(Task task) {
    setState(() {
      TaskController.insertTask(task);
      widget.tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _tasksListView(),
      floatingActionButton: AddTaskForm(
        onTaskCreate: _onTaskCreate,
      ),
    );
  }
}
