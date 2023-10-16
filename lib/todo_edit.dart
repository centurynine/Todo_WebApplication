import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'storage/todo_storage.dart';

class TodoEdit extends StatefulWidget {
  final Todo todo;

  const TodoEdit({super.key, required this.todo});

  @override
  State<TodoEdit> createState() => _TodoEditState(todo: todo);
}

String name = '';
String description = '';
String startDate = '';
String endDate = '';
String startTime = '';
String endTime = '';
DateTime endTimeWidget = DateTime.now();
DateTime startTimeWidget = DateTime.now();
bool check = false;

class _TodoEditState extends State<TodoEdit> {
  Todo todo;
  _TodoEditState({required this.todo});
  @override
  List<Todo> todoList = [];

  @override
  void initState() {
    setState(() {
      name = todo.name;
      description = todo.description;
      startDate = todo.startDate.toString().substring(0, 10);
      endDate = todo.endDate.toString().substring(0, 10);
      startTime = todo.startDate.toString().substring(11, 16);
      endTime = todo.endDate.toString().substring(11, 16);
      startTimeWidget = DateTime.parse(startDate).add(Duration(
        hours: int.parse(startTime.split(":")[0]),
        minutes: int.parse(startTime.split(":")[1].split(" ")[0]),
      ));
      endTimeWidget = DateTime.parse(endDate).add(Duration(
        hours: int.parse(endTime.split(":")[0]),
        minutes: int.parse(endTime.split(":")[1].split(" ")[0]),
      ));
      check = todo.check;
    });

    getDate();
    super.initState();
  }

  void getDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedList = prefs.getStringList('todo');
    if (encodedList != null) {
      List decodedList = encodedList.map((e) => json.decode(e)).toList();
      setState(() {
        todoList = decodedList.map((e) => Todo.fromMap(e)).toList();
      });
    }
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedList =
        todoList.map((e) => json.encode(e.toMap())).toList();
    prefs.setStringList('todo', encodedList);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(179, 167, 167, 167),
      appBar: AppBar(
          title: const Text('Todo edit'),
          backgroundColor: Colors.blueGrey[900],
          leading: IconButton(
            iconSize: 50,
            icon: const Icon(Icons.arrow_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(300, 10, 300, 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: nameField(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(300, 10, 300, 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: descriptionField(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: startDatePick(),
                ),
              ),
              Container(
                child: startDate.isNotEmpty
                    ? Text(startDate.substring(0, 10))
                    : const Text(''),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: startTimePick(),
                ),
              ),
              Container(
                child: startTime.isNotEmpty
                    ? Text(startTime.substring(0, 5))
                    : const Text(''),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: endDatePick(),
                ),
              ),
              Container(
                child: endDate.isNotEmpty
                    ? Text(endDate.substring(0, 10))
                    : const Text(''),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: endTimePick(),
                ),
              ),
              Container(
                child: endTime.isNotEmpty
                    ? Text(endTime.substring(0, 5))
                    : const Text(''),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: saveDate(),
            ),
          )
        ],
      ),
    );
  }

  ElevatedButton startDatePick() {
    return ElevatedButton(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: startTimeWidget,
          firstDate: DateTime(2023),
          lastDate: DateTime(2025),
        ).then((value) {
          if (value != null) {
            setState(() {
              startDate = value.toString();
            });
          }
        });
      },
      child: const Text('Start date'),
    );
  }

  ElevatedButton endDatePick() {
    return ElevatedButton(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: endTimeWidget,
          firstDate: DateTime(2023),
          lastDate: DateTime(2025),
        ).then((value) {
          if (value != null) {
            setState(() {
              endDate = value.toString();
            });
          }
        });
      },
      child: const Text('End date'),
    );
  }

  ElevatedButton startTimePick() {
    return ElevatedButton(
      onPressed: () {
        showTimePicker(
          context: context,
          initialTime: startTimeWidget.hour < 12
              ? TimeOfDay(
                  hour: startTimeWidget.hour, minute: startTimeWidget.minute)
              : TimeOfDay(
                  hour: startTimeWidget.hour - 12,
                  minute: startTimeWidget.minute),
        ).then((value) {
          if (value != null) {
            setState(() {
              startTime = value.format(context);
            });
          }
        });
      },
      child: const Text('Start time'),
    );
  }

  ElevatedButton endTimePick() {
    return ElevatedButton(
      onPressed: () {
        showTimePicker(
                context: context,
                initialTime: startTimeWidget == endTimeWidget
                    ? TimeOfDay(
                        hour: startTimeWidget.hour + 1,
                        minute: startTimeWidget.minute)
                    : endTimeWidget.hour < 12
                        ? TimeOfDay(
                            hour: endTimeWidget.hour,
                            minute: endTimeWidget.minute)
                        : TimeOfDay(
                            hour: endTimeWidget.hour - 12,
                            minute: endTimeWidget.minute))
            .then((value) {
          if (value != null) {
            setState(() {
              endTime = value.format(context);
            });
          }
        });
      },
      child: const Text('End time'),
    );
  }

  ElevatedButton saveDate() {
    return ElevatedButton(
      onPressed: () {
        if (name.isNotEmpty &&
            description.isNotEmpty &&
            startDate.isNotEmpty &&
            endDate.isNotEmpty &&
            startTime.isNotEmpty &&
            endTime.isNotEmpty) {
          DateTime startDateTime = DateTime.parse(startDate).add(Duration(
            hours: int.parse(startTime.split(":")[0]),
            minutes: int.parse(startTime.split(":")[1].split(" ")[0]),
          ));
          DateTime endDateTime = DateTime.parse(endDate).add(Duration(
            hours: int.parse(endTime.split(":")[0]),
            minutes: int.parse(endTime.split(":")[1].split(" ")[0]),
          ));
          if (endDateTime.isBefore(startDateTime)) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("End time cannot be before start time"),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            int todoIndex = todoList.indexWhere((item) => item.id == todo.id);
            if (todoIndex != -1) {
              todoList[todoIndex].name = name;
              todoList[todoIndex].description = description;
              todoList[todoIndex].startDate = startDateTime;
              todoList[todoIndex].endDate = endDateTime;
              todoList[todoIndex].check = check;
            }
            saveData();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Please fill in all fields"),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: const Text('Save'),
    );
  }
}

TextFormField nameField() {
  return TextFormField(
    initialValue: name,
    onChanged: (value) {
      name = value.trim();
    },
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter name';
      }
      return null;
    },
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    decoration: const InputDecoration(
      border: InputBorder.none,
      labelText: 'Name',
      prefixIcon: Icon(Icons.tornado_rounded),
      hintText: 'Name',
    ),
  );
}

TextFormField descriptionField() {
  return TextFormField(

    initialValue: description,
    onChanged: (value) {
      description = value.trim();
    },
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter description';
      }
      return null;
    },
    maxLines: 5,
    keyboardType: TextInputType.multiline,
    decoration: const InputDecoration(
      border: InputBorder.none,
      labelText: 'Description',
      prefixIcon: Icon(Icons.tornado_rounded),
      hintText: 'Description',
    ),
  );
}
