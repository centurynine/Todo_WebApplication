import 'package:flutter/material.dart';
import 'package:todo_application/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(179, 167, 167, 167),
        appBar: AppBar(
          title: const Text('Todo application'),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text('Todo List'),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                    ),
               
                  TodoItem(),
                ]),
              )
            ],
          ),
        ));
  }
}
