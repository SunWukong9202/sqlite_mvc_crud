import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../validator_helper.dart';

class FormEditTask extends StatefulWidget {
  final Function(Task) onTaskEdit;
  final Task task;
  const FormEditTask({super.key, required this.task, required this.onTaskEdit});

  @override
  State<FormEditTask> createState() => _FormEditTaskState();
}

class _FormEditTaskState extends State<FormEditTask> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  late Task task;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    task = widget.task;
    _titleController.text = task.title;
    super.initState();
  }

  Column _titleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
          validator: ValidatorHelper.validateEmptyField,
        ),
      ],
    );
  }

  final _formTitle = const Text(
    'Edit Task',
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  Form _form() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _formTitle,
          _titleInput(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              task.title = _titleController.text;
              widget.onTaskEdit(task);
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              _form(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _showDialog(context);
        },
        child: const Icon(Icons.edit));
  }
}
