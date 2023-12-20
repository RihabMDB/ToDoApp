import 'package:flutter/material.dart';
import 'package:todolist/widget/searchBoxWidget.dart';
import 'data/list_items.dart';
import 'widget/listWidget.dart';
import '../model/item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items = List.from(listItems);
  Set<CategirueFilter> filtersCategory = <CategirueFilter>{};

  @override
  Widget build(BuildContext context) => Column(
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
          SearchBoxWidget(items: items),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 5.0,
              children: CategirueFilter.values.map((CategirueFilter categorie) {
                return FilterChip(
                  backgroundColor: Color(0xffc6c1c1),
                  label: Text(categorie.name),
                  selected: filtersCategory.contains(categorie),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        filtersCategory.add(categorie);
                      } else {
                        filtersCategory.remove(categorie);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const Expanded(child: ListWidget()),
        ],
      );
}
