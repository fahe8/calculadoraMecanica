import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Velocidad extends StatefulWidget {
  const Velocidad({Key? key}) : super(key: key);

  @override
  _VelocidadState createState() => _VelocidadState();
}

class _VelocidadState extends State<Velocidad> {
//Controladores de formulario
  TextEditingController _controllerCaudal = TextEditingController();
  TextEditingController _controllerDiametro = TextEditingController();

// Obtén la instancia de CalculationsController
  final CalculationsController calculationsController =
      Get.find<CalculationsController>();

  @override
  void initState() {
    super.initState();
    // Llama a la función de utilidad para el controlador _controllerCaudal
    ControllerUtils.initializeAndListenController(
      controller: _controllerCaudal,
      controllerValue: calculationsController.caudal,
      calculationsController: calculationsController,
    );

    // Llama a la función de utilidad para el controlador _controllerDiametro
    ControllerUtils.initializeAndListenController(
      controller: _controllerDiametro,
      controllerValue: calculationsController.diametro,
      calculationsController: calculationsController,
    );
  }

  @override
  void dispose() {
    // Importante: asegúrate de eliminar el listener al salir de la pantalla para evitar pérdida de memoria.
    _controllerCaudal.dispose();
    _controllerDiametro.dispose();
    super.dispose();
  }

  void calcularVelocidad() {
    // Llama al método calcularVelocidad en CalculationsController
    calculationsController.calcularVelocidad();

    // Muestra el resultado en un diálogo o de otra manera
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar: MyAppBar(
        title: 'Velocidad',
        backgroundColor: Colors.orange,
        routeBack: () {
          Navigator.pushNamed(context, '/hidraulica/calculoshidraulicos');
        },
      ),
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
                  color: Colors.orange,
                  text: 'Caudal (m^3/s)',
                  hintText: 'Escribe el Caudal',
                  size: 15,
                  controller: _controllerCaudal,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                  color: Colors.orange,
                  text: 'Diámetro (m)',
                  hintText: 'Escribe el diametro',
                  size: 15,
                  controller: _controllerDiametro,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRectangle(
                      width: 80,
                      height: 50,
                      color: Colors.orange,
                      text: 'Resultado',
                      size: 15,
                    ),
                    Obx(
                      () => CustomRectangle(
                        width: 180,
                        height: 50,
                        color: Colors.grey.shade300,
                        text: calculationsController.velocidad.toString() +
                            ' m/s',
                        size: 18,
                      ),
                    )
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
                        height: 40,
                        color: Colors.grey.shade300,
                        text: 'Calcular',
                        size: 18,
                        onPressed: calcularVelocidad),
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
                        color: Colors.orange.shade300,
                        text: 'siguiente',
                        size: 13,
                        onPressed: () {
                          Navigator.pushNamed(context,
                              '/hidraulica/calculoshidraulicos/reynolds');
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
