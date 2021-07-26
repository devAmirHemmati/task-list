import 'package:flutter/material.dart';

class TaskModel {
  late String title;
  late bool isActive;
  late Color categoryColor;

  TaskModel({
    required this.title,
    required this.isActive,
    required this.categoryColor,
  });
}
