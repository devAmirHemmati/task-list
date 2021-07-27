import 'package:flutter/material.dart';
import 'package:my/model/task_model.dart';

class NewTaskScreen extends StatelessWidget {
  late TaskModel? task;

  NewTaskScreen({this.task});

  @override
  Widget build(BuildContext context) {
    print('my task: ');
    print(task);

    return Scaffold(
      body: Text("New Task"),
    );
  }
}
