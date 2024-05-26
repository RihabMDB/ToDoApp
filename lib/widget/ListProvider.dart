import 'package:flutter/widgets.dart';

import '../model/item.dart';

class ListProvider extends InheritedWidget {
  final void Function() onListUpdate;
  final List<Item>? items;
  final int size;
  const ListProvider(
      {Key? key,
      required super.child,
      required this.items,
      required this.size,
      required this.onListUpdate})
      : super(
          key: key,
        );

  static ListProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ListProvider>();
  }

  @override
  bool updateShouldNotify(ListProvider oldWidget) {
    return items != oldWidget.items; // ListProvider.of(context).list
  }
}
