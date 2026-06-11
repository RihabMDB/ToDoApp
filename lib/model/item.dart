import 'package:flutter/material.dart';
import 'package:todolist/utils/constants/categoryEnum.dart';

class Item {
  final String id;
  final String title;
  final String description;
  final String date;
  final CategoryEnum category;

  bool isDone;

  Item({
    // this.id=Uuid(),
    this.id = "l",
    required this.title,
    //this.urlImage,
    this.description = "",
    String? date,
    this.category = CategoryEnum.NoCategory,
    this.isDone = false,
  }) : date = date ?? _formatDate(DateTime.now());

  set setisDone(bool state) {
    isDone = state;
  }


  bool get getIsDone => isDone;

  static String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
