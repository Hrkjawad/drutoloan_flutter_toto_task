import 'package:drutoloan_flutter_todo_task/presentation/ui/widgets/todo_list_view.dart';
import 'package:flutter/material.dart';
import '../../data/model.dart';
import '../viewmodels/store_todo.dart';

class CompleteTodo extends StatefulWidget {
  const CompleteTodo({super.key});

  @override
  State<CompleteTodo> createState() => _CompleteTodoState();
}

class _CompleteTodoState extends State<CompleteTodo> {
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
    final completeTodos = store.todos
        .where((s) => s.status == 'completed')
        .toList();

    return Scaffold(
      body: TodoListView(todos: completeTodos, onDelete: _deleteTodo),
    );
  }
}
