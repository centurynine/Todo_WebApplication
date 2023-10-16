import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'storage/todo_storage.dart';

class TodoAdd extends StatefulWidget {
  const TodoAdd({super.key});

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

String name = '';
String description = '';
String startTime = '';
String endTime = '';
String startDate = '';
String endDate = '';

class _TodoAddState extends State<TodoAdd> {
  TimeOfDay time = TimeOfDay.now();
  @override
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

  void getDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedList = prefs.getStringList('todo');
    print(encodedList);
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
      backgroundColor: Color.fromARGB(179, 167, 167, 167),
      appBar: AppBar(
          title: const Text('Todo add'),
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
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: nameField(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(300, 10, 300, 10),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: startDatePick(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: startTimePick(),
                ),
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: endDatePick(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: endTimePick(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
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
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2025),
        ).then((value) {
          if (value != null) {
            setState(() {
              startDate = value.toString();
            });
          }
        });
        print(startDate);
      },
      child: const Text('Start date'),
    );
  }

  ElevatedButton endDatePick() {
    return ElevatedButton(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2025),
        ).then((value) {
          if (value != null) {
            setState(() {
              endDate = value.toString();
            });
            print(endDate);
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
          initialTime: TimeOfDay.now(),
        ).then((value) {
          if (value != null) {
            setState(() {
              startTime = value.format(context);
            });
          }
          print(startTime);
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
          initialTime: TimeOfDay.now(),
        ).then((value) {
          if (value != null) {
            setState(() {
              endTime = value.format(context);
            });
            print(endTime);
          }
        });
      },
      child: const Text('End time'),
    );
  }

ElevatedButton saveDate() {
  return ElevatedButton(
    onPressed: () {
      if (name.isNotEmpty && description.isNotEmpty && startDate.isNotEmpty && endDate.isNotEmpty && startTime.isNotEmpty && endTime.isNotEmpty) {
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
                title: Text("Error"),
                content: Text("End time cannot be before start time"),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          Todo todo = Todo(
            id: todoList.length + 1,
            name: name,
            description: description,
            startDate: startDateTime,
            endDate: endDateTime,
          );
          todoList.add(todo);
          saveData();
          Navigator.pop(context);
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please fill in all fields"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK"),
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
    onChanged: (value) {
      name = value.trim();
    },
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter name';
      }
      return null;
    },
    keyboardType: TextInputType.emailAddress,
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
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    decoration: const InputDecoration(
      border: InputBorder.none,
      labelText: 'Description',
      prefixIcon: Icon(Icons.tornado_rounded),
      hintText: 'Description',
    ),
  );
}
