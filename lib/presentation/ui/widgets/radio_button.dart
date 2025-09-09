import 'package:flutter/material.dart';

enum TaskStatus { ready, pending, complete }

class StatusRadioButtons extends StatelessWidget {
  final TaskStatus selectedStatus;
  final ValueChanged<TaskStatus> onChanged;

  const StatusRadioButtons({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return RadioGroup<TaskStatus>(
      groupValue: selectedStatus,
      onChanged: (TaskStatus? value) {
        if (value != null) onChanged(value);
      },
      child: Column(
        children: [
          RadioListTile(
            value: TaskStatus.ready,
            title: Text('Ready'),
            contentPadding: EdgeInsets.only(left: 125),
          ),
          RadioListTile(
            value: TaskStatus.pending,
            title: Text('Pending'),
            contentPadding: EdgeInsets.only(left: 125),
          ),
          RadioListTile(
            value: TaskStatus.complete,
            title: Text('Completed'),
            contentPadding: EdgeInsets.only(left: 125),
          ),
        ],
      ),
    );
  }
}

