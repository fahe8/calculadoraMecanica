import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final Color color;
  final String text;
  final String hintText;
  final double size;
  final TextEditingController controller;

  CustomInput({
    required this.color,
    required this.text,
    required this.hintText,
    required this.size,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Row(
        children: [
          CustomRectangle(
            width: 120,
            height: 50,
            color: color,
            text: text,
            size: size,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
