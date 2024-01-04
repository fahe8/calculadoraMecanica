import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final Color color;
  final String text;
  final String? hintText;
  final double size;
  final TextEditingController controller;
  final double? width;
  CustomInput({
    required this.color,
    required this.text,
     this.hintText,
    required this.size,
    required this.controller, this.width = 130,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColoresApp.greyShade,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Row(
        children: [
          CustomRectangle(
            width: width!,
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
              child:TextField(
           
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),

            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              suffixIcon: IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: Icon(Icons.clear),
              ),
            ),
            textAlign: TextAlign.start,
          ),
            ),
          ),
        ],
      ),
      
    );
  }
}
