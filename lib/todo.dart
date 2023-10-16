import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/storage/todo_storage.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  List<Todo> todoList = [];
  
  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? const Center(
            child: Text('No todo items'),
          )
        : Container(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: ListTile(
          title: Text('Todo item'),
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 152, 152, 152),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Start date: 2023',
                          style: TextStyle(color: Colors.white)),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 152, 152, 152),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('End date: 2024',
                          style: TextStyle(color: Colors.white)),
                    )),
              ],
            ),
          ),
          leading: Checkbox(
            value: false,
            onChanged: (bool? value) {
              
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit_note_rounded),
            onPressed: () {
              
            },
          ),
        ),
      ),
    );
  }
}