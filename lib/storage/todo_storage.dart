import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Todo {
  int id;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  bool check;

  Todo({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.check = false,
  });

  Todo.fromMap(Map map)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        startDate = DateTime.parse(map['startDate']),
        endDate = DateTime.parse(map['endDate']),
        check = map['check'];

  Map toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'check': check,
    };
  }

}
