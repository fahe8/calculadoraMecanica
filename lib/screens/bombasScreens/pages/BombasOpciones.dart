import 'dart:math';

import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/screens/bombasScreens/pages/DetallesBoma.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:calculator/widgets/RectangleBombas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BombasOpciones extends StatefulWidget {
  const BombasOpciones({Key? key}) : super(key: key);

  @override
  _BombasOpcionesState createState() => _BombasOpcionesState();
}

class _BombasOpcionesState extends State<BombasOpciones> {
  TextEditingController _controllerValorA = TextEditingController();
  TextEditingController _controllerValorB = TextEditingController();
  TextEditingController _controllerValorC = TextEditingController();
  TextEditingController _controllerValorQ = TextEditingController();

  final CalculationsController calculationsController =
      Get.find<CalculationsController>();

  void crearBomba() {
    // Obtén los valores de los controladores
    double valorA = double.parse(_controllerValorA.text);
    double valorB = double.parse(_controllerValorB.text);
    double? valorC;
    double valorQ = double.parse(_controllerValorQ.text);

// Intenta convertir el valorC, si no se proporciona un valor, será null
  valorC = double.tryParse(_controllerValorC.text);

// Llama al método crearNuevaBomba en CalculationsController

  }

  void mostrarVentanaModalCrearBomba() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Valores principales para realizar calculos'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('El valorC no es obligatorio'),
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de A*',
                    hintText: 'Valor A...',
                    size: 13,
                    width: 100,
                    controller: _controllerValorA,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de B*',
                    hintText: 'Valor B...',
                    size: 13,
                    width: 100,
                    controller: _controllerValorB,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de C',
                    hintText: 'Valor C...',
                    size: 13,
                    width: 100,
                    controller: _controllerValorC,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de Q*',
                    hintText: 'Valor Q...',
                    size: 13,
                    width: 100,
                    controller: _controllerValorQ,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      crearBomba();
                      Navigator.pop(context);
                    },
                    child: Text('Crear bomba'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Bombas',
          backgroundColor: Colors.blue,
          routeBack: () {
            Navigator.pushNamed(context, '/bombas');
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    'Listado de Bombas',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Obx(() => Column(
                  //       children: List.generate(
                  //         calculationsController.bombas.length,
                  //         (index) {
                  //           final bomba = calculationsController.bombas[index];

                  //           return Column(
                  //             children: [
                  //               RectangleBombas(
                  //                 color: bomba.color!,
                  //                 text: 'Opciones bomba ${index + 1}',
                  //                 onPressed:  () {
                  //                   // Navega a la pantalla de detalle usando Navigator.pushNamed
                  //                   Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                       builder: (context) =>
                  //                           DetallesBoma(index: index),
                  //                     ),
                  //                   );
                  //                 },
                  //               ),
                  //               SizedBox(
                  //                   height:
                  //                       10), // Agrega un SizedBox de 10 después de cada RectangleBombas
                  //             ],
                  //           );
                  //         },
                  //       ),
                  //     )),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRectangle(
                          width: 200,
                          height: 50,
                          color: Colors.grey.shade200,
                          text: 'Añadir nueva bomba',
                          size: 13,
                          onPressed: () {
                            mostrarVentanaModalCrearBomba();
                          }),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
