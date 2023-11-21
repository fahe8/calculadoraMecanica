import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Accesorios extends StatefulWidget {
  const Accesorios({Key? key}) : super(key: key);

  @override
  _AccesoriosState createState() => _AccesoriosState();
}

class _AccesoriosState extends State<Accesorios> {
  TextEditingController _controllerCoeficienteK = TextEditingController();
  TextEditingController _controllerVelocidad = TextEditingController();


  // Obtén la instancia de CalculationsController
  final CalculationsController calculationsController =
      Get.find<CalculationsController>();

  void initState() {
    super.initState();
    // Llama a la función de utilidad para el controlador _controllerVelocidad
    ControllerUtils.initializeAndListenController(
      controller: _controllerCoeficienteK,
      controllerValue: calculationsController.coeficienteK,
      calculationsController: calculationsController,
    );


    ControllerUtils.initializeAndListenController(
      controller: _controllerVelocidad,
      controllerValue: calculationsController.velocidad,
      calculationsController: calculationsController,
    );
  }

  @override
  void dispose() {
    // Importante: asegúrate de eliminar el listener al salir de la pantalla para evitar pérdida de memoria.
    _controllerCoeficienteK.dispose();
    _controllerVelocidad.dispose();
    super.dispose();
  }

  void calcularPerdidasDeAccesorios() {
    // Llama al método calcularVelocidad en CalculationsController
    calculationsController.calcularPerdidasAccesorios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar: MyAppBar(
          title: 'Pérdidas: Accesorios',
          backgroundColor: Colors.orange,
          routeBack: () {
            Navigator.pushNamed(context, '/hidraulica/calculoshidraulicos');
          }),
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
                    text: 'Coeficiente K',
                    hintText: 'Escribe el Coeficiente K',
                    size: 15,
                    controller: _controllerCoeficienteK),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.orange,
                    text: 'Velocidad (m/s)',
                    hintText: 'Escribe la velocidad',
                    size: 15,
                    controller: _controllerVelocidad),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
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
                            text: calculationsController.perdidasAccesorios
                                .toString(),
                            size: 18,
                          ),
                        )
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
                          height: 40,
                          color: Colors.grey.shade300,
                          text: 'Calcular',
                          size: 18,
                          onPressed: calcularPerdidasDeAccesorios,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomRectangle(
                            width: 80,
                            height: 30,
                            color: Colors.grey.shade300,
                            text: 'anterior',
                            size: 13,
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    )
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
