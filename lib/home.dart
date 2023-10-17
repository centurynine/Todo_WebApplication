import 'package:flutter/material.dart';
import 'package:todo_application/todo.dart';
import 'package:todo_application/todo_add.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 26, 31, 35),
      
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                 
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      children: [
                       Text('Todo List',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: GoogleFonts.kanit().fontFamily,
                            )),
                        IconButton(
                          icon: const Icon(Icons.add_box_rounded,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TodoAdd()));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(shrinkWrap: true, children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TodoItem(),
                  ),
                ]),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const TodoAdd()));
                },
                child: const Icon(
                  Icons.add_box_rounded,
                  color: Color.fromARGB(255, 55, 55, 55),
                ),
                backgroundColor: Colors.white,
              )
            ],
          ),
        ));
  }
}
