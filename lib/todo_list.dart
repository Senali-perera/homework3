import 'package:flutter/material.dart';
import 'package:homework3/todo.dart';

import 'add_todo.dart';


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState()=>_TodoListState();
}

class _TodoListState extends State<TodoList>{
  final List<Todo> _todos = [];

  void _initialiseTodoList(){
    if (_todos.isEmpty){
      for (var i = 0; i <= 100; i++) {
        Todo newToDo = Todo("Buy Groceries $i" , false, "description");
        _todos.add(newToDo);
      }
    }
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

  }

  @override
  void initState() {
    super.initState();
    _initialiseTodoList();
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