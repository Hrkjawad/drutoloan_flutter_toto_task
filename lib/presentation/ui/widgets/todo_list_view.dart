import 'package:drutoloan_flutter_todo_task/core/app_color.dart';
import 'package:flutter/material.dart';
import '../../../data/model.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key, required this.todos, required this.onDelete});

  final List<Todo> todos;
  final void Function(Todo todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (_, index) {
        final todo = todos[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppMainColor.primaryColor,
            foregroundColor: Colors.white,
            child: Text('${index + 1}'),
          ),
          title: Text(todo.title),
          subtitle: Text('${todo.description}\n${todo.createdAtString}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(todo),
          ),
        );
      },
    );
  }
}
