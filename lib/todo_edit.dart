import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'storage/todo_storage.dart';

class TodoEdit extends StatefulWidget {
  final Todo todo;

  const TodoEdit({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoEdit> createState() => _TodoEditState(todo: todo);
}

class _TodoEditState extends State<TodoEdit> {
  Todo todo;
  _TodoEditState({required this.todo});
  List<Todo> todoList = [];
  String name = '';
  String description = '';
  String startDate = '';
  String endDate = '';
  String startTime = '';
  String endTime = '';
  DateTime endTimeWidget = DateTime.now();
  DateTime startTimeWidget = DateTime.now();
  bool check = false;

  @override
  void initState() {
    setState(() {
      name = todo.name;
      description = todo.description;
      startDate = todo.startDate.toString().substring(0, 10);
      endDate = todo.endDate.toString().substring(0, 10);
      startTime = todo.startDate.toString().substring(11, 16);
      endTime = todo.endDate.toString().substring(11, 16);
      startTimeWidget = DateTime.parse(startDate).add(
        Duration(
          hours: int.parse(startTime.split(":")[0]),
          minutes: int.parse(startTime.split(":")[1]),
        ),
      );
      endTimeWidget = DateTime.parse(endDate).add(
        Duration(
          hours: int.parse(endTime.split(":")[0]),
          minutes: int.parse(endTime.split(":")[1]),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(179, 167, 167, 167),
      appBar: AppBar(
        title: Text(
          'Todo edit',
          style: TextStyle(
            fontFamily: GoogleFonts.kanit().fontFamily,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          iconSize: 50,
          icon: const Icon(Icons.arrow_left_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
            SizedBox(
            height: 200,
          ),
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
                    ? Text(
                        startDate.substring(0, 10),
                        style: TextStyle(
                          fontFamily: GoogleFonts.kanit().fontFamily,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      )
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
                    ? Text(
                        startTime,
                        style: TextStyle(
                          fontFamily: GoogleFonts.kanit().fontFamily,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      )
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
                    ? Text(
                        endDate.substring(0, 10),
                        style: TextStyle(
                          fontFamily: GoogleFonts.kanit().fontFamily,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      )
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
                    ? Text(
                        endTime,
                        style: TextStyle(
                          fontFamily: GoogleFonts.kanit().fontFamily,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      )
                    : const Text(''),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(
              width: 100,
              height: 50,
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
              startDate = value.toString().substring(0, 10);
            });
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 26, 31, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Start date',
        style: TextStyle(
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
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
              endDate = value.toString().substring(0, 10);
            });
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 26, 31, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'End date',
        style: TextStyle(
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  ElevatedButton startTimePick() {
    return ElevatedButton(
      onPressed: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(startTimeWidget),
        ).then((value) {
          if (value != null) {
            setState(() {
              final hour = value.hour.toString().padLeft(2, '0');
              final minute = value.minute.toString().padLeft(2, '0');
              startTime = '$hour:$minute';
            });
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 26, 31, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Start time',
        style: TextStyle(
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  ElevatedButton endTimePick() {
    return ElevatedButton(
      onPressed: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(endTimeWidget),
        ).then((value) {
          if (value != null) {
            setState(() {
              final hour = value.hour.toString().padLeft(2, '0');
              final minute = value.minute.toString().padLeft(2, '0');
              endTime = '$hour:$minute';
            });
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 26, 31, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'End time',
        style: TextStyle(
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
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
          DateTime startDateTime = DateTime.parse(startDate).add(
            Duration(
              hours: int.parse(startTime.split(":")[0]),
              minutes: int.parse(startTime.split(":")[1]),
            ),
          );
          DateTime endDateTime = DateTime.parse(endDate).add(
            Duration(
              hours: int.parse(endTime.split(":")[0]),
              minutes: int.parse(endTime.split(":")[1]),
            ),
          );
          if (endDateTime.isBefore(startDateTime) ||
              endDateTime.isAtSameMomentAs(startDateTime)) {
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
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 26, 31, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Save',
        style: TextStyle(
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
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
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Name',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: GoogleFonts.kanit().fontFamily,
        ),
        prefixIcon: Icon(Icons.tornado_rounded),
        hintText: 'Name',
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontSize: 15,
          color: Colors.black,
        ),
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
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Description',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: GoogleFonts.kanit().fontFamily,
        ),
        prefixIcon: Icon(Icons.description_rounded),
        hintText: 'Description',
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
