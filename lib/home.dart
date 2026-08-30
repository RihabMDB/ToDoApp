import 'package:flutter/material.dart';
import 'package:todolist/widget/searchBoxWidget.dart';
import 'package:todolist/services/hive_service.dart';
import 'widget/ListProvider.dart';
import 'widget/listWidget.dart';
import 'package:todolist/model/item.dart';
import 'package:todolist/utils/constants/categoryEnum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Item> items;
  late List<Item> allItems;
  late int size;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    allItems = HiveService.getAllItems();
    items = allItems;
    size = items.length;
  }

  //List<CategoryEnum> categories = [];
  List<String> selectedCategories = [CategoryEnum.All.name];
  void onListUpdate() {
    setState(() {
      if (selectedCategories.contains(CategoryEnum.All.name)) {
        items = allItems;
      } else if (selectedCategories.isNotEmpty) {
        items = allItems.where((todo) {
          return selectedCategories.contains(todo.category.name);
        }).toList();
      }
      size = items.length;
    });
  }

  void onSearch(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        onListUpdate();
      } else {
        items = allItems
            .where((todo) =>
                todo.title.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
        size = items.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListProvider(
      items: items,
      size: size,
      onListUpdate: onListUpdate,
      onSearch: onSearch,
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
