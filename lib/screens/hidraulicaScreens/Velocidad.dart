import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/screens/hidraulicaScreens/CalculosScreen.dart';
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
  final TextEditingController _controllerCaudal = TextEditingController();
  final TextEditingController _controllerDiametro = TextEditingController();

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

    super.dispose();
  }

  void calcularVelocidad() {
    // Llama al método calcularVelocidad en CalculationsController
    calculationsController.calcularVelocidad();

    // Muestra el resultado en un diálogo o de otra manera
  }

  @override
  Widget build(BuildContext context) {
    return HydraulicCalculationScreen(
      title: 'Velocidad',
      controllers: [_controllerCaudal, _controllerDiametro],
      values: calculationsController.velocidad,
      inputLabels: ['Caudal', 'Diámetro'],
      calculateMethod: calcularVelocidad,
      nextRoute: '/hidraulica/calculoshidraulicos/reynolds',
    );
  }
}
