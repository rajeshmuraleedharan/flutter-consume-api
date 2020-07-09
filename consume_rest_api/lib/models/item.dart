
import 'package:flutter/foundation.dart';

class Item {
  final int id;
  final String body;
  final bool completed;

  Item({@required this.id, @required this.body, this.completed = false});

  Item copyWith({int id, String body, bool completed}) {
    return Item(
      id: id ?? this.id, 
      body: body ?? this.body,
      completed: completed ?? this.completed,
    );
  }

  Item.fromJson(Map json)
      : id = json["id"],
        body = json["body"],
        completed = json["completed"];

  Map toJson() => {
    "id": id,
    "body": body,
    "completed": completed,
  };

  @override
  String toString() => toJson().toString();
}
