import 'package:todolist/model/item.dart';

final List<Item> listItemsData = [
  Item(
      id: "1",
      title: "Milk",
      description: "here is some text to test",
      category: CategoryEnum.All,
      isDone: true),
  Item(
      id: "2",
      title: "Apple",
      description: "111 here is some text to test",
      category: CategoryEnum.Personnal,
      isDone: true),
  Item(
      id: "3",
      title: "Perso",
      description: "1122 here is ",
      category: CategoryEnum.Personnal),
  Item(id: "4", title: "Milk", description: "000 here is"),
  Item(
      id: "4",
      title: "Marry",
      description: "some thing to do",
      category: CategoryEnum.Nothing),
  Item(id: "4", title: "Milk", description: "000 here is"),
];
final List<String> listCotegories = [
  "Nothing",
  "Personnal",
  "Work",
];

//enum CategoryEnum { All, Personnal, Work }
