import 'package:flutter/material.dart';
import 'ListProvider.dart';

class SearchBoxWidget extends StatefulWidget {
  const SearchBoxWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  var items, size;

  void _runFilter(String enteredKeyword) {
    final provider = ListProvider.of(context);
    if (provider == null) return;

    if (enteredKeyword.isNotEmpty) {
      provider.onSearch?.call(enteredKeyword);
    } else {
      provider.onListUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ListProvider.of(context);
    items = provider!.items;
    size = provider.size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
