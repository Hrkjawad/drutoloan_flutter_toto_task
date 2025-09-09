import 'package:drutoloan_flutter_todo_task/presentation/ui/pending_todo.dart';
import 'package:drutoloan_flutter_todo_task/presentation/ui/ready_todo.dart';
import 'package:flutter/material.dart';

import '../../core/app_color.dart';
import 'add_todo.dart';
import 'completed_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  int _selectBottomIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drutoloan Todo Task")),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectBottomIndex,
        indicatorColor: AppMainColor.primaryColor,
        onDestinationSelected: (int index) {
          setState(() {
            _selectBottomIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: _selectBottomIndex == 0 ? Colors.white : Colors.grey,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.check_circle_rounded,
              color: _selectBottomIndex == 1 ? Colors.white : Colors.grey,
            ),
            label: "Ready",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.timelapse_rounded,
              color: _selectBottomIndex == 2 ? Colors.white : Colors.grey,
            ),
            label: "Pending",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.done_all_rounded,
              color: _selectBottomIndex == 3 ? Colors.white : Colors.grey,
            ),
            label: "Completed",
          ),
        ],
      ),
      body: SafeArea(child: IndexedStack(
        index: _selectBottomIndex,
        children: [
          AddTodo(),
          ReadyTodo(),
          PendingTodo(),
          CompleteTodo()
        ],
      )),
    );
  }
}
