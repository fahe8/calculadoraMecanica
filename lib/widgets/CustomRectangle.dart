import 'package:flutter/material.dart';

class CustomRectangle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String? text;
  final VoidCallback? onPressed;
  final double size;

  CustomRectangle({
    required this.width,
    required this.height,
    required this.color,
    this.text,
    this.onPressed,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        width: width,
        height: height,
        child: Center(
          child: Text(
            text!,
            style: TextStyle(
              color: Colors.black,
              fontSize: size,
            ),
          ),
        ),
      ),
    );
  }
}
