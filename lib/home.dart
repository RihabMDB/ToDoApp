import 'package:flutter/material.dart';
import 'package:todolist/widget/searchBoxWidget.dart';
import 'data/list_items.dart';
import 'widget/ListProvider.dart';
import 'widget/listWidget.dart';
import '../model/item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items = List.from(listItemsData);
  List<Item> allItems = List.from(listItemsData);
  int size = List.from(listItemsData).length;

  //List<CategoryEnum> categories = [];
  List<String> selectedCategories = ["All"];
  void onListUpdate() {
    setState(() {
      if (selectedCategories.contains("All")) {
        items = allItems;
      } else if (selectedCategories.isNotEmpty) {
        items = allItems.where((todo) {
          return selectedCategories.contains(todo.category.name);
        }).toList();
      }
      size = items.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListProvider(
      items: items,
      size: size,
      onListUpdate: onListUpdate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 10),
            child: Text(
              "All tasks",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontFamily: 'Open Sans',
              ),
            ),
          ),
          SearchBoxWidget(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 5.0,
              children: CategoryEnum.values.map((CategoryEnum categorie) {
                return FilterChip(
                  backgroundColor: Color(0xffc6c1c1),
                  label: Text(categorie.name),
                  selected: selectedCategories.contains(categorie.name),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        if (categorie.name == "All") {
                          selectedCategories = ["All"];
                        } else {
                          selectedCategories.remove("All");
                          selectedCategories.add(categorie.name);
                        }
                        onListUpdate();
                      } else {
                        if (categorie.name != "All") {
                          selectedCategories.remove(categorie.name);
                          if (selectedCategories.isEmpty) {
                            selectedCategories.add("All");
                          }
                          onListUpdate();
                        }
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(child: ListWidget()),
        ],
      ),
    );
  }
}
