import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LongitudTuberia extends StatefulWidget {
  const LongitudTuberia({Key? key}) : super(key: key);

  @override
  _LongitudTuberiaState createState() => _LongitudTuberiaState();
}

class _LongitudTuberiaState extends State<LongitudTuberia> {
  TextEditingController _controllerFriccion = TextEditingController();
  TextEditingController _controllerDiametro = TextEditingController();
  TextEditingController _controllerLongitud = TextEditingController();
  TextEditingController _controllerCaudal = TextEditingController();

  // Obtén la instancia de CalculationsController
  final CalculationsController calculationsController =
      Get.find<CalculationsController>();

  void initState() {
    super.initState();
    // Llama a la función de utilidad para el controlador _controllerVelocidad
    ControllerUtils.initializeAndListenController(
      controller: _controllerFriccion,
      controllerValue: calculationsController.factorFriccion,
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
      controller: _controllerLongitud,
      controllerValue: calculationsController.longitud,
      calculationsController: calculationsController,
    );
    ControllerUtils.initializeAndListenController(
      controller: _controllerCaudal,
      controllerValue: calculationsController.caudal,
      calculationsController: calculationsController,
    );
  }

  @override
  void dispose() {
    // Importante: asegúrate de eliminar el listener al salir de la pantalla para evitar pérdida de memoria.
    _controllerFriccion.dispose();
    _controllerDiametro.dispose();
    _controllerLongitud.dispose();
    _controllerCaudal.dispose();
    super.dispose();
  }

  void calcularPerdidasDeLongitudTuberia() {
    // Llama al método calcularVelocidad en CalculationsController
    calculationsController.calcularPerdidasLongitudTuberia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar: MyAppBar(
          title: 'Pérdidas: Longitud de Tuberia',
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
                    text: 'F. Frincción',
                    hintText: 'Escribe la Friccion',
                    size: 15,
                    controller: _controllerFriccion),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.orange,
                    text: 'Diámetro (m)',
                    hintText: 'Escribe el diámetro',
                    size: 15,
                    controller: _controllerDiametro),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.orange,
                    text: 'Longitud (m)',
                    hintText: 'Escribe la Longitud',
                    size: 15,
                    controller: _controllerLongitud),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.orange,
                    text: 'Caudal',
                    hintText: 'Escribe el Caudal',
                    size: 15,
                    controller: _controllerCaudal),
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
                            text: calculationsController.perdidasLongitudTuberia
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
                          onPressed: calcularPerdidasDeLongitudTuberia,
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
                                  '/hidraulica/calculoshidraulicos/accesorios');
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
