import 'package:flutter/material.dart';

class RectangleBombas extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressed;
  final bool options;
  final VoidCallback? edit;
  final VoidCallback? delete;

  const RectangleBombas(
      {Key? key,
      required this.color,
      required this.text,
      this.onPressed,
      this.options = false,
      this.edit,
      this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: options,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    edit!();
                  } else if (value == 'delete') {
                    delete!();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Editar'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Eliminar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
