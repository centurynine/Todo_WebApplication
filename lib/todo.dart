import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/storage/todo_storage.dart';
import 'todo_edit.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key});
  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final monthNames = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  List<Todo> todoList = [];
  Color checkColor = Colors.white;

  @override
  void initState() {
    getDate();
    super.initState();
  }

  void getDate() {
    SharedPreferences.getInstance().then((prefs) {
      List<String>? encodedList = prefs.getStringList('todo');
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

  String formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month;
    final year = dateTime.year.toString();
    return '$day ${monthNames[month]} $year';
  }

 String dateCompareDifferent(DateTime endDate) {
  final now = DateTime.now();
  final difference = endDate.difference(now);
  final days = difference.inDays;
  return days.toString();
}

 String hourCompareDifferent(DateTime endDate) {
  final now = DateTime.now();
  final difference = endDate.difference(now);
  final hours = difference.inHours;
  return hours.toString();
}


  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? Center(
            child: Text('No todo',
                style: TextStyle(
                    fontFamily: GoogleFonts.kanit().fontFamily,
                    fontSize: 20,
                    color: Colors.white)),
          )
        : StreamBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          todoList[index].check == true
                              ? Row(
                                  children: [
                                    Text(todoList[index].name,
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.kanit().fontFamily,
                                            fontSize: 25,
                                            decoration:
                                                TextDecoration.lineThrough)),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        'Completed',
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.kanit().fontFamily,
                                            fontSize: 15,
                                            color: Colors.green),
                                      ),
                                    ),
                                  ],
                                )
                              : todoList[index].endDate.isAfter(DateTime.now())
                                  ? Text(todoList[index].name,
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.kanit().fontFamily,
                                          fontSize: 25))
                                  : Row(
                                      children: [
                                        Text(todoList[index].name,
                                            style: TextStyle(
                                                fontFamily: GoogleFonts.kanit()
                                                    .fontFamily,
                                                fontSize: 25,
                                                decoration: TextDecoration
                                                    .lineThrough)),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 0, 0),
                                          child: Text(
                                            'Expired',
                                            style: TextStyle(
                                                fontFamily: GoogleFonts.kanit()
                                                    .fontFamily,
                                                fontSize: 15,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                          Text(todoList[index].description,
                              style: TextStyle(
                                  fontFamily: GoogleFonts.kanit().fontFamily,
                                  fontSize: 20)),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 90, 199, 86),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Start date: ${formatDateTime(todoList[index].startDate)} Time: ${todoList[index].startDate.toString().substring(11, 16)}',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.kanit().fontFamily,
                                          color: Colors.white)),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 216, 121, 121),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'End date: ${formatDateTime(todoList[index].endDate)} Time: ${todoList[index].endDate.toString().substring(11, 16)}',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.kanit().fontFamily,
                                          color: Colors.white)),
                                )),                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 131, 201, 220),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: int.parse(dateCompareDifferent(todoList[index].endDate)) > 1 
                                  ? Text('${dateCompareDifferent(todoList[index].endDate)} days left',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.kanit().fontFamily,
                                          color: Colors.white))
                                  : Text('${dateCompareDifferent(todoList[index].endDate)} day left',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.kanit().fontFamily,
                                          color: Colors.white)),
                                )),
                          ],
                        ),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Checkbox(
                          splashRadius: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          activeColor: Colors.green,
                          checkColor: Colors.white,
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
                              icon: const Icon(Icons.remove_circle_rounded,
                                  color: Color.fromARGB(255, 221, 63, 57)),
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
                              icon: const Icon(
                                Icons.edit_note_rounded,
                                color: Color.fromARGB(255, 93, 148, 24),
                              ),
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
            );
          });
  }
}
