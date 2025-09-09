import 'dart:convert';
import 'dart:io';
import 'package:drutoloan_flutter_todo_task/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/model.dart';
import 'store_todo.dart';

class JsonImportService {
  static const platform = MethodChannel('app.channel.shared.files');

  static Future<void> pickJsonFile(BuildContext context) async {
    try {
      final String? path = await platform.invokeMethod('pickJson');
      if (path != null) {
        final file = File(path);
        final content = await file.readAsString();
        final List<dynamic> list = jsonDecode(content);

        final todos = list.map((e) => Todo.fromJson(e)).toList();

        await store.importTodo(todos);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppMainColor.primaryColor,
              content: const Text("JSON file uploaded successfully"),
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orange,
              content: Text("JSON import canceled"),
            ),
          );
        }
      }
    } on PlatformException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("Failed to pick JSON: ${e.message}"),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("Wrong JSON Format: $e"),
          ),
        );
      }
    }
  }
}
