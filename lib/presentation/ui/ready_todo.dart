import 'package:drutoloan_flutter_todo_task/presentation/ui/widgets/todo_list_view.dart';
import 'package:flutter/material.dart';
import '../../data/model.dart';
import '../viewmodels/store_todo.dart';

class ReadyTodo extends StatefulWidget {
  const ReadyTodo({super.key});

  @override
  State<ReadyTodo> createState() => _ReadyTodoState();
}

class _ReadyTodoState extends State<ReadyTodo> {
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
    final readyTodos = store.todos.where((s) => s.status == 'ready').toList();
    return Scaffold(
      body: TodoListView(todos: readyTodos, onDelete: _deleteTodo),
    );
  }
}
