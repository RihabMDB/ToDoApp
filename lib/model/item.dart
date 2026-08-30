import 'package:hive/hive.dart';
import 'package:todolist/utils/constants/categoryEnum.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final CategoryEnum category;

  @HiveField(5)
  bool isDone;

  Item({
    // this.id=Uuid(),
    this.id = "l",
    required this.title,
    this.description = "",
    String? date,
    this.category = CategoryEnum.NoCategory,
    this.isDone = false,
  }) : date = date ?? _formatDate(DateTime.now());

  bool get getIsDone => isDone;

  static String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
