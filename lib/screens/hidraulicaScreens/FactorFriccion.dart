import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';

class FactorFriccion extends StatefulWidget {
  const FactorFriccion({Key? key}) : super(key: key);

  @override
  _FactorFriccionState createState() => _FactorFriccionState();
}

class _FactorFriccionState extends State<FactorFriccion> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar:
          MyAppBar(title: 'Factor de Fricción', backgroundColor: Colors.green),
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
                    text: 'Rugosidad (m)',
                    hintText: 'Escribe la Rugosidad',
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
                    text: 'N# Reynolds',
                    hintText: 'Escribe el número de Reynolds',
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
