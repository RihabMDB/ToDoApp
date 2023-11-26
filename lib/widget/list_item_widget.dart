import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/item.dart';

class ListItemWidget extends StatelessWidget {
  final Item item;
  final Animation<double> animation;
  final VoidCallback removeCallback;

  const ListItemWidget({
    required this.item,
    required this.animation,
    required this.removeCallback,
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
          contentPadding: EdgeInsets.all(16),
          leading: Icon(
            item.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.grey,
          ),
          /*CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(item.urlImage),
          ),*/
          title: Text(
            item.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              " 21 Oct",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
            ),
            onPressed: removeCallback,
            // => removeCallback,
          ),
        ),
      );
}

Widget CustomCheckBox(bool value) {
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
