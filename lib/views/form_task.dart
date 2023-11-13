import 'dart:math';

import 'package:flutter/material.dart';
import '../validator_helper.dart';
import '../models/task_model.dart';

class AddTaskForm extends StatefulWidget {
  final Function(Task) onTaskCreate;
  const AddTaskForm({super.key, required this.onTaskCreate});

  @override
  State<AddTaskForm> createState() => _FormState();
}

class _FormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
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
    'New Task',
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
              var task = Task(
                  title: _titleController.text,
                  expireDate: _randomShiftedDate(
                    DateTime.now(),
                    const Duration(hours: 48),
                  ));
              // setState(() {
              widget.onTaskCreate(task);
              // });
            },
            child: const Text('Crear'),
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

  DateTime _randomShiftedDate(DateTime baseDate, Duration maxShift) {
    Random random = Random();
    int randomHours = random.nextInt(maxShift.inHours);

    return baseDate.add(Duration(hours: randomHours));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showDialog(context);
      },
      child: const Icon(Icons.add),
    );
  }
}
