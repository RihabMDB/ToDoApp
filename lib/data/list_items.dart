import 'package:todolist/model/item.dart';

final List<Item> listItems = [
  Item(
      id: "1",
      title: "Milk",
      description: "here is some text to test",
      isDone: true),
  Item(
      id: "2",
      title: "Apple",
      description: "111 here is some text to test",
      isDone: true),
  Item(id: "3", title: "Milk", description: "1122 here is "),
  Item(id: "4", title: "Milk", description: "000 here is"),
];

final List<String> listCotegories = [
  "No category",
  "Personnal",
  "Work",
];

enum CategirueFilter { All, Personnal, Work }
