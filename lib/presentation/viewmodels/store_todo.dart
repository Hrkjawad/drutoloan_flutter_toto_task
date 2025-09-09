import 'dart:io';
import '../../core/csv_read_write.dart';
import '../../data/model.dart';

class Store {
  late CsvService csvService;
  final List<Todo> todos = [];

  Store() {
    csvService = CsvService('${Directory.systemTemp.path}/todos.csv');
  }

  Future<void> loadTodos() async {
    final loaded = await csvService.readTodos();
    todos
      ..clear()
      ..addAll(loaded);
  }

  Future<void> addTodo(Todo todo) async {
    todos.add(todo);
    await csvService.saveTodos(todos);
  }
  Future<void> importTodo(List<Todo> newTodos) async {
    todos.addAll(newTodos);
    await csvService.saveTodos(todos);
  }


  Future<void> deleteTodo(Todo todo) async {
    todos.remove(todo);
    await csvService.saveTodos(todos);
  }
}

final store = Store();
