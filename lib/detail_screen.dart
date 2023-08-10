import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_model_provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController title = TextEditingController();

  TextEditingController description = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<ToDoModelProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new task'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  Navigator.of(context).pop(const DetailsScreen());
                  task.addTask(title.text, description.text);
                }
              },
              icon: const Icon(
                Icons.check_sharp,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                controller: title,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                controller: description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
