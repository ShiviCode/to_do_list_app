import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_app/todo_model_provider.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ToDoModelProvider(),
      child: MaterialApp(
        title: 'ToDo App',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

