import 'package:drutoloan_flutter_todo_task/core/store_todo.dart';

import '../../data/model.dart';

class TodoService {
  Future<void> addTodo(
    String title,
    String description,
    int time,
    String status,
  ) async {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      createdAt: time,
      status: status,
    );
    await store.addTodo(todo);
  }
}
