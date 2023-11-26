import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Item {
  final String id;
  final String title;
  final String description;
  final String date;
  final String category;
  bool isDone;

  Item({
    // this.id=Uuid(),
    this.id = "l",
    required this.title,
    //this.urlImage,
    this.description = "",
    this.date = "18/10/2023",
    this.category = "",
    this.isDone = false,
  });

  set setisDone(bool state) {
    isDone = state;
  }
}
