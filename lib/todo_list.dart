import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework3/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_todo.dart';


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState()=>_TodoListState();
}

class _TodoListState extends State<TodoList>{
  List<Todo> _todos = [];

  void loadTodos() async {
    final prefs = await SharedPreferences.getInstance
      ();
    List<String> stringList = prefs.getStringList('todos') ?? [];

    setState(() {
      _todos = stringList.map((item) {
        var parts = item.split(',');
        return Todo(parts[0], parts[1] == 'true', parts[2], imagePath: parts.length > 2 ? parts[3] : null);
      }).toList();
    });
  }

  void saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList = _todos.map((todo) => '${todo.title},${todo.isDone},${todo.description},${todo.imagePath ?? ''}').toList();
    await prefs.setStringList('todos', stringList);
  }

  void _addTodoItem(BuildContext context) async{
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddTodo(),
        ));

    setState(() {
      _todos.add(result);
    });
    saveTodos();
  }

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Widget _viewTodoItem(Todo todo){
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.description),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          setState(() {
            _todos.remove(todo);
          });
        },
      ),
      leading: todo.imagePath == null? const Image(image: AssetImage('assets/images/no_image.jpeg')) : Image.file(File(todo.imagePath!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return _viewTodoItem(_todos[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          _addTodoItem(context);
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}