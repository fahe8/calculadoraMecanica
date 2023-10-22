import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Velocidad extends StatefulWidget {
  const Velocidad({Key? key}) : super(key: key);

  @override
  _VelocidadState createState() => _VelocidadState();
}

class _VelocidadState extends State<Velocidad> {
//Controladores de formulario
  TextEditingController _controllerCaudal = TextEditingController();
  TextEditingController _controllerDiametro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar: MyAppBar(title: 'Velocidad', backgroundColor: Colors.green),
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
                    controller: _controllerCaudal),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.green,
                    text: 'Diámetro (m)',
                    hintText: 'Escribe el diametro',
                    size: 15,
                    controller: _controllerDiametro),
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
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
