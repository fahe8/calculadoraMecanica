import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeleccionBomba extends StatefulWidget {
  const SeleccionBomba({Key? key}) : super(key: key);

  @override
  State<SeleccionBomba> createState() => _SeleccionBombaState();
}

class _SeleccionBombaState extends State<SeleccionBomba> {
  //Controladores de formulario
  TextEditingController _controllerValorA = TextEditingController();
  TextEditingController _controllerValorB = TextEditingController();
  TextEditingController _controllerCaudalTrabajo = TextEditingController();

// Obtén la instancia de CalculationsController
  final CalculationsController calculationsController =
      Get.find<CalculationsController>();

  void crearBomba() {
    // Obtén los valores de los controladores
    double valorA = double.parse(_controllerValorA.text);
    double valorB = double.parse(_controllerValorB.text);
    double caudalTrabajo = double.parse(_controllerCaudalTrabajo.text);

// Llama al método crearNuevaBomba en CalculationsController
    calculationsController.crearNuevaBomba(valorA, valorB, caudalTrabajo);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar: MyAppBar(
        title: 'Bombas',
        backgroundColor: Colors.blue,
        routeBack: () {
          Navigator.pushNamed(context, '/bombas');
        },
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(
            'assets/bomba.png',
            width: 200,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Curva Resistente',
                  style: TextStyle(color: Colors.white),
                ),
                CustomInput(
                  color: Colors.blue,
                  text: 'Valor de A',
                  hintText: 'Valor A...',
                  size: 15,
                  controller: _controllerValorA,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                  color: Colors.blue,
                  text: 'Valor de B',
                  hintText: 'Valor B...',
                  size: 15,
                  controller: _controllerValorB,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                  color: Colors.blue,
                  text: 'Caudal de trabajo',
                  hintText: 'Caudal...',
                  size: 15,
                  controller: _controllerCaudalTrabajo,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRectangle(
                        width: 200,
                        height: 50,
                        color: Colors.grey.shade300,
                        text: 'Continuar',
                        size: 13,
                        onPressed: () {
                          crearBomba();
                          Navigator.pushNamed(
                              context, '/bombas/seleccionBombas/opciones');
                        }),
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
