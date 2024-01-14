import 'package:flutter/material.dart';
import 'package:homework3/todo.dart';

class AddTodo extends StatelessWidget {
  // const AddTodo({super.key});
  final TextEditingController _textTitleFieldController = TextEditingController();
  final TextEditingController _textDescriptionFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: AlertDialog(
        title: Text('Add a new todo item'),
        content: Column(
          children: [
            TextField(
              controller: _textTitleFieldController,
              decoration: InputDecoration(hintText: 'Enter todo title here'),
            ),
            TextField(
              controller: _textDescriptionFieldController,
              decoration:
              InputDecoration(hintText: 'Enter todo description here'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _addTodoItem(context);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  void _addTodoItem(BuildContext context){
    String title = _textTitleFieldController.text;
    String description = _textDescriptionFieldController.text;
    Todo todo = Todo(title, false, description);
    Navigator.pop(context, todo);

  }
}
