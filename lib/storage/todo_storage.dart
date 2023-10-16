class Todo {
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  bool check;

  Todo(
      {required this.name,
      required this.description,
      required this.startDate,
      required this.endDate,
      this.check = false,
      });

      Todo.fromMap(Map map) :
        name = map['name'],
        description = map['description'],
        startDate = DateTime.parse(map['startDate']),
        endDate = DateTime.parse(map['endDate']),
        check = map['check'];

  Map toMap() {
    return {
      'name': name,
      'description': description,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'check': check,
    };
  }
  
}