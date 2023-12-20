import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../data/list_items.dart';
import '../model/item.dart';
import '../widget/list_item_widget.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final _listKey = GlobalKey<AnimatedListState>();
  final List<Item> items = List.from(listItems);
  List<Item> _foundItem = [];
  /*
  @override
  void initState() {
    _foundItem = items;
    super.initState();
  }*/

  void checkBoxChange(bool? value, int index) {
    setState(() {
      items[index].isDone = value!;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedList(
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
                onToDoChanged: () => _handleToDoChange,
                onChange: (value) => checkBoxChange(value, index),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showModal(),
      ));

  void removeItem(int index) {
    final removedItem = items[index];
    // remove it from the list
    items.removeAt(index);
    // remove it from the animated list

    _listKey.currentState!.removeItem(
        index,
        (context, animation) => ListItemWidget(
            item: removedItem,
            animation: animation,
            removeCallback: () {},
            onToDoChanged: () {}));
  }

  void _handleToDoChange(Item item) {
    print("teest object ");
    print(item.isDone);
    setState(() {
      item.isDone = true;
    });
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
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    hintText: 'Input a description',
                  ),
                  onChanged: (value) => description = value,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          );
        });
  }
}
