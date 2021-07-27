import 'package:flutter/material.dart';

class TaskModel {
  late String id;
  late String title;
  late bool isActive;
  late Color categoryColor;

  TaskModel({
    required this.id,
    required this.title,
    required this.isActive,
    required this.categoryColor,
  });
}
