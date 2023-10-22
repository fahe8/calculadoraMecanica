import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumeroReynolds extends StatefulWidget {
  const NumeroReynolds({Key? key}) : super(key: key);

  @override
  _NumeroReynoldsState createState() => _NumeroReynoldsState();
}

class _NumeroReynoldsState extends State<NumeroReynolds> {
  //Controladores de formulario
  TextEditingController _controller = TextEditingController();

  // Obtén la instancia de CalculationsController
  final CalculationsController calculationsController =
      Get.find<CalculationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar:
          MyAppBar(title: 'Número de Reynolds', backgroundColor: Colors.green),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(
            'assets/velocidad.png',
            width: 200,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomInput(
                    color: Colors.green,
                    text: 'Velocidad (m/s)',
                    hintText: 'Escribe la velocidad',
                    size: 15,
                    controller: _controller),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.green,
                    text: 'Diámetro (m)',
                    hintText: 'Escribe el diametro',
                    size: 15,
                    controller: _controller),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.green,
                    text: 'V. Cinemática ',
                    hintText: 'Escribe la Viscocidad Cinemática',
                    size: 15,
                    controller: _controller),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomRectangle(
                          width: 200,
                          height: 30,
                          color: Colors.grey.shade300,
                          text: 'Usar valores del cálculo anterior',
                          size: 13,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRectangle(
                      width: 80,
                      height: 30,
                      color: Colors.green,
                      text: 'Resultado',
                      size: 15,
                    ),
                    CustomRectangle(
                      width: 180,
                      height: 30,
                      color: Colors.grey.shade300,
                      text: calculationsController.velocidad.toString(),
                      size: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomRectangle(
                          width: 80,
                          height: 30,
                          color: Colors.grey.shade300,
                          text: 'Calcular',
                          size: 13,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
