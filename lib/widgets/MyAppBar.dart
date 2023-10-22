import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  MyAppBar({required this.title, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(title),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.infinity,
        60,
      );
}
