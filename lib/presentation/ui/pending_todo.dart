import 'package:drutoloan_flutter_todo_task/presentation/ui/widgets/todo_list_view.dart';
import 'package:flutter/material.dart';
import '../../data/model.dart';
import '../../core/store_todo.dart';

class PendingTodo extends StatefulWidget {
  const PendingTodo({super.key});

  @override
  State<PendingTodo> createState() => _PendingTodoState();
}

class _PendingTodoState extends State<PendingTodo> {
  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    await store.loadTodos();
    setState(() {});
  }

  Future<void> _deleteTodo(Todo todo) async {
    await store.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pendingTodos = store.todos
        .where((s) => s.status == 'pending')
        .toList();

    return Scaffold(
      body: TodoListView(todos: pendingTodos, onDelete: _deleteTodo),
    );
  }
}
