import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/model/item.dart';

class HiveService {
  static const String itemsBoxName = 'items';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ItemAdapter());
    await Hive.openBox<Item>(itemsBoxName);
  }

  static Box<Item> getItemsBox() {
    return Hive.box<Item>(itemsBoxName);
  }

  static Future<void> addItem(Item item) async {
    final box = getItemsBox();
    await box.put(item.id, item);
  }

  static Future<void> updateItem(Item item) async {
    final box = getItemsBox();
    await box.put(item.id, item);
  }

  static Future<void> deleteItem(String itemId) async {
    final box = getItemsBox();
    await box.delete(itemId);
  }

  static List<Item> getAllItems() {
    final box = getItemsBox();
    return box.values.toList();
  }

  static Future<void> clearAllItems() async {
    final box = getItemsBox();
    await box.clear();
  }

  static Item? getItem(String itemId) {
    final box = getItemsBox();
    return box.get(itemId);
  }
}
