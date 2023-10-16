import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/storage/todo_storage.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
   
   List<Todo> todoList = [
    Todo(
        id: 1,
        name: 'Todo item 1',
        description: 'Todo item 1 description',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        check: false),Todo(
        id: 1,
        name: 'Todo item 2',
        description: 'Todo item 2 description',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        check: false),
  ];

 
  @override

  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
       
     });
  }

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
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: ListTile(
                        title: Text(todoList[index].name),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 152, 152, 152),
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
                                    color:
                                        const Color.fromARGB(255, 152, 152, 152),
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
                          onChanged: (bool? value) {},
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit_note_rounded),
                          onPressed: () {},
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
