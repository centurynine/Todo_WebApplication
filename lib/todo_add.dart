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
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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
          )
        ),
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
        
          ],
        ),
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

  