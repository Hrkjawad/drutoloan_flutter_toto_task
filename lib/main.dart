import 'package:drutoloan_flutter_todo_task/core/app_color.dart';
import 'package:drutoloan_flutter_todo_task/presentation/ui/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drutoloan Flutter ToDo Task',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppMainColor.primaryColor,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: AppMainColor.primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}
