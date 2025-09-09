import 'package:drutoloan_flutter_todo_task/presentation/ui/widgets/custom_text_form_field.dart';
import 'package:drutoloan_flutter_todo_task/presentation/ui/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import '../../core/app_color.dart';
import '../../core/json_service.dart';
import '../../data/model.dart';
import '../viewmodels/add_todo_data.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  TaskStatus _status = TaskStatus.ready;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  int currentTimestamp() => DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    int currentTime = currentTimestamp();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            const SizedBox(height: 50),
            customTextFormField(_titleController, "Title", 1),
            customTextFormField(_descriptionController, "Description", 4),
            StatusRadioButtons(
              selectedStatus: _status,
              onChanged: (value) {
                setState(() => _status = value);
              },
            ),
            Text(
              "Created At: ${Todo(id: 0, title: '', description: '', createdAt: currentTime, status: '').createdAtString}",
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  //final currentTime = timeNow();
                  TodoService().addTodo(
                    _titleController.text,
                    _descriptionController.text,
                    currentTimestamp(),
                    _status.toString().split('.').last,
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppMainColor.primaryColor,
                        content: const Text("Todo added successfully"),
                      ),
                    );
                  }
                  _titleController.clear();
                  _descriptionController.clear();
                  setState(() {
                    currentTime = currentTimestamp();
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: const Text("Please Type Tile and Description"),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppMainColor.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text("Add ToDo"),
            ),
            ElevatedButton(
              onPressed: () async {
                await JsonImportService.pickJsonFile(context);
                setState(() {});
              },
              child: const Text("Import JSON"),
            ),
          ],
        ),
      ),
    );
  }
}
