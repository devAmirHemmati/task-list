import 'package:flutter/material.dart';
import 'package:my/model/category_model.dart';

class TaskModel {
  late String id;
  late String title;
  late bool isActive;
  late CategoryModel category;

  TaskModel({
    required this.id,
    required this.title,
    required this.isActive,
    required this.category,
  });
}
