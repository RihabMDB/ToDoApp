import 'package:flutter/material.dart';

import 'data/list_items.dart';
import 'model/item.dart';
import 'widget/list_item_widget.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 0, 6, 42),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: listCotegories.map((chipLabel) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Chip(
                        label: Text(chipLabel),
                        // You can customize  the chip's appearance here
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Expanded(child: MainPage()),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _listKey = GlobalKey<AnimatedListState>();
  final List<Item> items = List.from(listItems);
  List<Item> _foundItem = [];

  @override
  void initState() {
    _foundItem = items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // searchBox(),
          AnimatedList(
            key: _listKey,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) {
              return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Colors.transparent,
                  child: ListItemWidget(
                    item: items[index],
                    animation: animation,
                    removeCallback: () => removeItem(index),
                  ));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showModal(),
      ));
  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
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
    );
  }

  void removeItem(int index) {
    final removedItem = items[index];
    // remove it from the list
    items.removeAt(index);
    // remove it from the animated list
    _listKey.currentState!.removeItem(
        index,
        (context, animation) => ListItemWidget(
            item: removedItem, animation: animation, removeCallback: () {}));
  }

  void insertItem(Item item) {
    //print(item.description);
    const newIndex = 0;
    final newItem = Item(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: item.title,
        description: item.description);
    items.insert(newIndex, newItem);
    _listKey.currentState!.insertItem(
      newIndex,
      duration: Duration(milliseconds: 600),
    );
  }

  Widget modalAddItem(context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Add Todo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  _showModal() {
    //onChanged: (value) => title = value,
    late String title;
    late String description;
    String category = listCotegories.first;

    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 30,
              children: <Widget>[
                const SizedBox(height: 15),
                TextField(
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: 'Input the title',
                  ),
                  onChanged: (value) => title = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 6,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: 'Input a description',
                  ),
                  onChanged: (value) => description = value,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            // color: Colors.red,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: category,
                          items: listCotegories
                              .map<DropdownMenuItem<String>>((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              category = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        backgroundColor: const Color.fromARGB(255, 1, 16, 29),
                        onPressed: () {
                          insertItem(Item(
                              title: title,
                              description: description,
                              category: "category"));
                        },
                        child: const Icon(
                          Icons.send_sharp,
                          size: 20,
                          color: Color.fromARGB(255, 249, 250, 251),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void _runFilter(String enteredKeyword) {
    List<Item> results = [];
    if (enteredKeyword.isEmpty) {
      results = items;
    } else {
      results = items
          .where((item) =>
              item.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundItem = results;
    });
  }
}
