import 'dart:io';

class Todo {
  String title;
  bool isDone;
  String description;
  File? image;

  Todo(this.title, this.isDone, this.description);
}