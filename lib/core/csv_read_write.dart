import 'dart:io';

import '../data/model.dart';

class CsvService {
  final String filePath;

  CsvService(this.filePath);

  Future<List<Todo>> readTodos() async {
    final file = File(filePath);
    if (!await file.exists()) return [];
    final lines = await file.readAsLines();
    return lines.map((line) => Todo.fromCsv(line)).toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final file = File(filePath);
    final content = todos.map((t) => t.toCsv()).join('\n');
    await file.writeAsString(content);
  }
}
