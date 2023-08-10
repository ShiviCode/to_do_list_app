import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_app/detail_screen.dart';
import 'package:to_do_list_app/todo_model_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final task = Provider.of<ToDoModelProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s task to do'),
      ),
      body: task.taskList.isEmpty
          ? const Center(
              child: Text(
                'Add New tasks...',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: task.taskList.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: ValueKey(task.taskList[index].id),
                  background: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) {
                    return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text('are you sure?'),
                              content:
                                  const Text('Do you want to delete the task'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                    },
                                    child: const Text('YES')),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                    child: const Text('NO')),
                              ],
                            ));
                  },
                  onDismissed: (direction) {
                    Provider.of<ToDoModelProvider>(context, listen: false)
                        .deleteProduct(task.taskList[index].id);
                  },
                  child: GestureDetector(
                    onTap: () {
                      task.toggle(task.taskList[index].id);
                    },
                    child: Card(
                      color: task.taskList[index].isChacked
                          ? const Color.fromARGB(255, 184, 255, 188)
                          : Colors.white,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        title: Text(
                          '${task.taskList[index].title}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text('${task.taskList[index].description}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                            overflow: TextOverflow.ellipsis),
                        leading: task.taskList[index].isChacked
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : const Icon(Icons.check_circle_outline),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: const Text('are you sure?'),
                                      content: const Text(
                                          'Do you want to delete the task'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Provider.of<ToDoModelProvider>(
                                                      context,
                                                      listen: false)
                                                  .deleteProduct(
                                                      task.taskList[index].id);
                                              Navigator.of(ctx).pop();
                                            },
                                            child: const Text('YES')),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: const Text('NO')),
                                      ],
                                    ));
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DetailsScreen(),
            ),
          );
        },
      ),
    );
  }
}
