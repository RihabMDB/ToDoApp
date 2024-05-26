import 'package:flutter/material.dart';
import '../model/item.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final Animation<double> animation;
  final VoidCallback removeCallback;
  final VoidCallback onToDoChanged;
  final Function(bool?)? onChange;
  const ItemWidget({
    required this.item,
    required this.animation,
    required this.removeCallback,
    required this.onToDoChanged,
    this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      SizeTransition(sizeFactor: animation, child: buildItem());

  Widget buildItem() => Container(
        //margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 27, 46, 115),
        ),
        child: ListTile(
          onTap: () => onChange,
//onToDoChanged(),
          contentPadding: EdgeInsets.all(16),
          leading: Icon(
            item.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.grey,
          ),
          title: Text(
            item.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: item.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
                Text(
                  item.date,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
            ),
            onPressed: removeCallback,
          ),
        ),
      );
}

// not used
Widget customCheckBox(bool value) {
  return Transform.scale(
    scale: 1.5,
    child: Checkbox(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      activeColor: Color.fromARGB(255, 106, 133, 177),
      side: BorderSide(
        width: 1,
        color: value ? Colors.black : Colors.grey,
      ),
      checkColor: Colors.white,
      value: value,
      onChanged: (changedValue) {
        // value = changedValue!;
      },
    ),
  );
}
