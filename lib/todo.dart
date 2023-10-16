import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/storage/todo_storage.dart';

import 'todo_edit.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  List<Todo> todoList = [];

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  void initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getDate();
  }

  void getDate() {
    SharedPreferences.getInstance().then((prefs) {
      List<String>? encodedList = prefs.getStringList('todo');
      print(encodedList);
      if (encodedList != null) {
        List decodedList = encodedList.map((e) => json.decode(e)).toList();
        setState(() {
          todoList = decodedList.map((e) => Todo.fromMap(e)).toList();
        });
      }
    });
  }

  Future saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedList =
        todoList.map((e) => json.encode(e.toMap())).toList();
    prefs.setStringList('todo', encodedList);
  }

  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? const Center(
            child: Text('No todo items'),
          )
        : StreamBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: ListTile(
                        title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(todoList[index].name,
                                style: const TextStyle(fontSize: 20)
                            ), 
                            Text(todoList[index].description),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Row(
                            children: [
                              
                              Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 152, 152, 152),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Start date: ${todoList[index].startDate.toString().substring(0, 10)} Time: ${todoList[index].startDate.toString().substring(11, 16)}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 152, 152, 152),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'End date: ${todoList[index].endDate.toString().substring(0,10)} Time: ${todoList[index].endDate.toString().substring(11, 16)}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  )),
                            ],
                          ),
                        ),
                        leading: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Checkbox(
                            value: todoList[index].check,
                            onChanged: (bool? value) async {
                              setState(() {
                                todoList[index].check = value ?? false;
                              });
                              await saveData();
                            },
                          ),
                        ),
                        trailing: Container(
                          width: 90,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_rounded),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Delete todo'),
                                          content: const Text(
                                              'Are you sure you want to delete this todo?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    todoList.removeAt(index);
                                                  });
                                                  saveData();
                                                },
                                                child: const Text('Delete')),
                                          ],
                                        );
                                      });
                                 
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit_note_rounded),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TodoEdit(todo: todoList[index])));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          });
  }

 

}
