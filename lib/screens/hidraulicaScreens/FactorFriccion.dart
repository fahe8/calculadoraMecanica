import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorFriccion extends StatefulWidget {
  const FactorFriccion({Key? key}) : super(key: key);

  @override
  _FactorFriccionState createState() => _FactorFriccionState();
}

class _FactorFriccionState extends State<FactorFriccion> {
  TextEditingController _controllerRugosidad = TextEditingController();
  TextEditingController _controllerDiametro = TextEditingController();
  TextEditingController _controllerReynolds = TextEditingController();

  // Obtén la instancia de CalculationsController
  final CalculationsController calculationsController =
      Get.find<CalculationsController>();

  void initState() {
    super.initState();
    // Llama a la función de utilidad para el controlador _controllerVelocidad
    ControllerUtils.initializeAndListenController(
      controller: _controllerRugosidad,
      controllerValue: calculationsController.rugosidad,
      calculationsController: calculationsController,
    );

    // Llama a la función de utilidad para el controlador _controllerDiametro
    ControllerUtils.initializeAndListenController(
      controller: _controllerDiametro,
      controllerValue: calculationsController.diametro,
      calculationsController: calculationsController,
    );
    // Llama a la función de utilidad para el controlador _controllerCinematica
    ControllerUtils.initializeAndListenController(
      controller: _controllerReynolds,
      controllerValue: calculationsController.numeroReynolds,
      calculationsController: calculationsController,
    );
  }

  @override
  void dispose() {
    // Importante: asegúrate de eliminar el listener al salir de la pantalla para evitar pérdida de memoria.
    _controllerRugosidad.dispose();
    _controllerDiametro.dispose();
    _controllerReynolds.dispose();
    super.dispose();
  }

  void calcularFactorDeFriccion() {
    // Llama al método calcularVelocidad en CalculationsController
    calculationsController.calcularFactorFriccion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar: MyAppBar(
          title: 'Factor de Fricción',
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
                    text: 'Rugosidad (m)',
                    hintText: 'Escribe la Rugosidad',
                    size: 15,
                    controller: _controllerRugosidad),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.orange,
                    text: 'Diámetro (m)',
                    hintText: 'Escribe el diametro',
                    size: 15,
                    controller: _controllerDiametro),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.orange,
                    text: 'N# Reynolds',
                    hintText: 'Escribe el número de Reynolds',
                    size: 15,
                    controller: _controllerReynolds),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
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
                            text: calculationsController.factorFriccion
                                .toString(),
                            size: 18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
                          onPressed: calcularFactorDeFriccion,
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
                        SizedBox(
                          width: 20,
                        ),
                        CustomRectangle(
                            width: 80,
                            height: 30,
                            color: Colors.orange.shade300,
                            text: 'siguiente',
                            size: 13,
                            onPressed: () {
                              Navigator.pushNamed(context,
                                  '/hidraulica/calculoshidraulicos/longitudtuberia');
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
