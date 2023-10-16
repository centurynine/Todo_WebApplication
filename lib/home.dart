import 'package:flutter/material.dart';
import 'package:todo_application/todo.dart';
import 'package:todo_application/todo_add.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 26,31,35),
        appBar: AppBar(
          title: const Text('Todo Application'),
          backgroundColor: Colors.blueGrey[900],
        ),
        
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      children: [
                        const Text('Todo List',
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        IconButton(
                          icon: const Icon(Icons.add_box_rounded),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TodoAdd()));
                        
                          },)
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                  TodoItem(),
                ]),
              )
            ],
          ),
        ));
  }
}
