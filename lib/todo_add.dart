import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'storage/todo_storage.dart';

class TodoAdd extends StatefulWidget {
  const TodoAdd({super.key});

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  TimeOfDay time = TimeOfDay.now();
  List<Todo> todoList = [];
  String name = '';
  String description = '';
  String startTime = '';
  String endTime = '';
  String startDate = '';
  String endDate = '';

  @override
  void initState() {
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
      backgroundColor: const Color.fromARGB(255, 26, 31, 35),
      appBar: AppBar(
          title: Text('Todo add',
              style: TextStyle(
                  fontFamily: GoogleFonts.kanit().fontFamily,
                  fontSize: 20,
                  color: Colors.white)),
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
          const SizedBox(
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
                child: startDate == ''
                    ? Text('#Date',
                        style: TextStyle(
                            fontFamily: GoogleFonts.kanit().fontFamily,
                            fontSize: 15,
                            color: Colors.white))
                    : Text(startDate.toString().substring(0, 10),
                        style: TextStyle(
                            fontFamily: GoogleFonts.kanit().fontFamily,
                            fontSize: 15,
                            color: Colors.white)),
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
                child: startTime == ''
                    ? Text('#Time',
                        style: TextStyle(
                            fontFamily: GoogleFonts.kanit().fontFamily,
                            fontSize: 15,
                            color: Colors.white))
                    : Text(startTime.toString(),
                        style: TextStyle(
                            fontFamily: GoogleFonts.kanit().fontFamily,
                            fontSize: 15,
                            color: Colors.white)),
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
                  child: endDate == ''
                      ? Text('#Date',
                          style: TextStyle(
                              fontFamily: GoogleFonts.kanit().fontFamily,
                              fontSize: 15,
                              color: Colors.white))
                      : Text(endDate.toString().substring(0, 10),
                          style: TextStyle(
                              fontFamily: GoogleFonts.kanit().fontFamily,
                              fontSize: 15,
                              color: Colors.white))),
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
                child: endTime == ''
                    ? Text('#Time',
                        style: TextStyle(
                            fontFamily: GoogleFonts.kanit().fontFamily,
                            fontSize: 15,
                            color: Colors.white))
                    : Text(endTime.toString(),
                        style: TextStyle(
                            fontFamily: GoogleFonts.kanit().fontFamily,
                            fontSize: 15,
                            color: Colors.white)),
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
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 114, 199, 117), //
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), //
        ),
      ),
      child: Text('Start date',
          style: TextStyle(
              fontFamily: GoogleFonts.kanit().fontFamily,
              fontSize: 20,
              color: Colors.white)),
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
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 216, 121, 121), //
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), //
        ),
      ),
      child: Text('End date',
          style: TextStyle(
              fontFamily: GoogleFonts.kanit().fontFamily,
              fontSize: 20,
              color: Colors.white)),
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
                final hour = value.hour.toString().padLeft(2, '0');
                final minute = value.minute.toString().padLeft(2, '0');
                startTime = '$hour:$minute';
              });
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 114, 199, 117), //
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), //
          ),
        ),
        child: Text('Start time',
            style: TextStyle(
                fontFamily: GoogleFonts.kanit().fontFamily,
                fontSize: 20,
                color: Colors.white)));
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
              final hour = value.hour.toString().padLeft(2, '0');
              final minute = value.minute.toString().padLeft(2, '0');
              endTime = '$hour:$minute';
            });
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 216, 121, 121), //
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), //
        ),
      ),
      child: Text('End time',
          style: TextStyle(
              fontFamily: GoogleFonts.kanit().fontFamily,
              fontSize: 20,
              color: Colors.white)),
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
          if (endDateTime.isBefore(startDateTime) ||
              endDateTime == startDateTime) {
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
            Todo todo = Todo(
              id: todoList.length + 1,
              name: name,
              description: description,
              startDate: startDateTime,
              endDate: endDateTime,
            );
            todoList.add(todo);
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), //
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), //
        ),
      ),
      child: Text('Save',
          style: TextStyle(
              fontFamily: GoogleFonts.kanit().fontFamily,
              fontSize: 20,
              color: Colors.black)),
    );
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
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Name',
        labelStyle: TextStyle(
            fontFamily: GoogleFonts.kanit().fontFamily,
            fontSize: 15,
            color: Colors.black),
        prefixIcon: const Icon(Icons.tornado_rounded),
        hintText: 'Name',
        hintStyle: TextStyle(
            fontFamily: GoogleFonts.kanit().fontFamily,
            fontSize: 15,
            color: Colors.black),
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
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Description',
          labelStyle: TextStyle(
            fontFamily: GoogleFonts.kanit().fontFamily,
            fontSize: 15,
            color: Colors.black,
          ),
          prefixIcon: const Icon(Icons.description_rounded),
          hintText: 'Description',
          hintStyle: TextStyle(
              fontFamily: GoogleFonts.kanit().fontFamily,
              fontSize: 15,
              color: Colors.black)),
    );
  }
}
