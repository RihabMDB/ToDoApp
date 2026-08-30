import 'package:flutter/material.dart';
import 'package:todolist/utils/constants/categoryEnum.dart';
import 'package:todolist/widget/ListProvider.dart';
import 'package:todolist/services/hive_service.dart';
import '../model/item.dart';
import 'item_widget.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final _listKey = GlobalKey<AnimatedListState>();

  var items, size;

  void checkBoxChange(bool? value, int index) {
    setState(() {
      items![index].isDone = value!;
      // Save to Hive
      HiveService.updateItem(items![index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ListProvider.of(context);
    items = provider!.items;
    size = provider.size;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedList(
            key: _listKey,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) {
              if (items != null && items.length > index) {
                final item = items![index];

                return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: Colors.transparent,
                    child: ItemWidget(
                      item: item,
                      animation: animation,
                      removeCallback: () => removeItem(index),
                      onToDoChanged: () => _handleToDoChange,
                      onChange: (value) => checkBoxChange(value, index),
                    ));
              } else {
                return const Text("");
              }
            }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _showModal(),
        ));
  }

  void removeItem(int index) {
    final removedItem = items![index];
    // remove it from the list
    setState(() {
      items!.removeAt(index);
    });

    // Delete from Hive
    HiveService.deleteItem(removedItem.id);

    // remove it from the animated list

    _listKey.currentState!.removeItem(
        index,
        (context, animation) => ItemWidget(
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
    const newIndex = 0;
    final newItem = Item(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: item.title,
        description: item.description,
        category: item.category,
        date: item.date);
    setState(() {
      items!.insert(newIndex, newItem);
      _listKey.currentState!.insertItem(
        newIndex,
        duration: Duration(milliseconds: 600),
      );
    });

    // Save to Hive
    HiveService.addItem(newItem);
  }

  _showModal() {
    late String title;
    late String description;
    late String date = _formatDate(DateTime.now());
    String selectedCategory = CategoryEnum.NoCategory.name;

    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.grey[300] ?? Colors.grey,
                        width: 1.0,
                      ),
                      color: Colors.grey[50],
                    ),
                    child: TextField(
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'task title',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(179, 158, 158, 158),
                          fontSize: 16,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) => title = value,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.grey[300] ?? Colors.grey,
                          width: 1.0,
                        ),
                        color: Colors.grey[50],
                      ),
                      child: TextField(
                        maxLines: 6,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'task notes',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(179, 158, 158, 158),
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) => description = value,
                      )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Category button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _showCategoryModal(context, (category) {
                              setModalState(() {
                                selectedCategory = category;
                              });
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: Colors.grey[300] ?? Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              selectedCategory,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Date picker button
                      GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            date = _formatDate(picked);
                            print(" picked date: $date");
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.grey[300] ?? Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Add button (FAB style)
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: const Color.fromARGB(255, 1, 16, 29),
                        onPressed: () {
                          if (title.isNotEmpty) {
                            insertItem(Item(
                                title: title,
                                description: description,
                                date: date,
                                category: CategoryEnum.values.firstWhere(
                                    (e) => e.name == selectedCategory)));
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(
                          Icons.send,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                ],
              ),
            );
          });
        });
  }

  void _showCategoryModal(
      BuildContext context, Function(String) onCategorySelected) {
    //final categories = CategoryEnum.values.map((e) => e.name).toList();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: CategoryEnum.values.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onCategorySelected(CategoryEnum.values[index].name);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: index == CategoryEnum.values.length - 1
                            ? Colors.transparent
                            : Colors.grey[200] ?? Colors.grey,
                      ),
                    ),
                  ),
                  child: Text(
                    CategoryEnum.values[index].name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  static String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
