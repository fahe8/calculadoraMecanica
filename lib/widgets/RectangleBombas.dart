import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:flutter/material.dart';

class RectangleBombas extends StatelessWidget {
  final Color color;
  final String text;
    final VoidCallback? onPressed;
  const RectangleBombas({Key? key, required this.color, required this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
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
          ],
        ),
      ),
    );
  }
}
