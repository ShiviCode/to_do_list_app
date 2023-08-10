import 'package:flutter/foundation.dart';
import 'package:to_do_list_app/todo_model.dart';

class ToDoModelProvider extends ChangeNotifier {
  List<TodoModel> taskList = [];

  void toggle(int id) {
    var todoModel = taskList.firstWhere((element) => element.id == id);
    todoModel.isChacked = !todoModel.isChacked;
    notifyListeners();
  }

  void addTask(String title, String description) {
    taskList.add(TodoModel(
      taskList.length + 1,
      title: title,
      description: description,
    ));
    notifyListeners();
  }

  void deleteProduct(int id) {
    taskList.removeWhere((pId) => pId.id == id);
    notifyListeners();
  }
}
