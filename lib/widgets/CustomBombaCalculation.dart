import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:flutter/material.dart';

class CustomBombaCalculation extends StatelessWidget {
  final VoidCallback onpressed;
  final TextEditingController controllerValorA;
  final TextEditingController controllerValorB;
  final TextEditingController controllerValorC;
  final String image;
  const CustomBombaCalculation(
      {Key? key,
      required this.onpressed,
      required this.controllerValorA,
      required this.controllerValorB,
      required this.controllerValorC, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            image,
            width: 200,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                children: [
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de A',
                    hintText: 'Valor A...',
                    size: 15,
                    controller: controllerValorA,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de B',
                    hintText: 'Valor B...',
                    size: 15,
                    controller: controllerValorB,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de C',
                    hintText: 'Valor C...',
                    size: 15,
                    controller: controllerValorC,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRectangle(
                        width: 100,
                        height: 40,
                        color: ColoresApp.greyShade,
                        text: 'Calcular',
                        size: 13,
                        onPressed: onpressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
