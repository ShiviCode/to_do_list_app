import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_app/detail_screen.dart';
import 'package:to_do_list_app/todo_model.dart';
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
        title: Text('Today\'s task to do'),
      ),
      body: task.taskList.isEmpty
          ? Center(
              child: Text('Add New tasks...',style: TextStyle(fontSize: 20),),
            )
          : ListView.builder(
              itemCount: task.taskList.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: ValueKey(task.taskList[index].id),
                  background: Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) {
                    return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text('are you sure?'),
                              content: Text('Do you want to delete the task'),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                    },
                                    child: Text('YES')),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                    child: Text('NO')),
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
                          ? Color.fromARGB(255, 184, 255, 188)
                          : Colors.white,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(15),
                        title: Text(
                          '${task.taskList[index].title}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),

                        subtitle: Text(
                          '${task.taskList[index].description}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        //leading: Icon(Icons.check_circle_outline),

                        leading: task.taskList[index].isChacked
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : Icon(Icons.check_circle_outline),

                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: Text('are you sure?'),
                                      content: Text(
                                          'Do you want to delete the task'),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Provider.of<ToDoModelProvider>(
                                                      context,
                                                      listen: false)
                                                  .deleteProduct(
                                                      task.taskList[index].id);
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text('YES')),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text('NO')),
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
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsScreen(),
            ),
          );
        },
      ),
    );
  }
}
