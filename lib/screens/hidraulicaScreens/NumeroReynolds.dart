import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/screens/hidraulicaScreens/CalculosScreen.dart';
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
  TextEditingController _controllerVelocidad = TextEditingController();
  TextEditingController _controllerDiametro = TextEditingController();
  TextEditingController _controllerCinematica = TextEditingController();

  // Obtén la instancia de CalculationsController
  final CalculationsController calculationsController =
      Get.find<CalculationsController>();

  void initState() {
    super.initState();
    // Llama a la función de utilidad para el controlador _controllerVelocidad
    ControllerUtils.initializeAndListenController(
      controller: _controllerVelocidad,
      controllerValue: calculationsController.velocidad,
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
      controller: _controllerCinematica,
      controllerValue: calculationsController.viscosidadCinematica,
      calculationsController: calculationsController,
    );
  }

  @override
  void dispose() {
    // Importante: asegúrate de eliminar el listener al salir de la pantalla para evitar pérdida de memoria.
    _controllerVelocidad.dispose();
    _controllerDiametro.dispose();
    _controllerCinematica.dispose();
    super.dispose();
  }

  void calcularNumerodeReynolds() {
    // Llama al método calcularVelocidad en CalculationsController
    calculationsController.calcularNumeroReynolds();
  }

  @override
   Widget build(BuildContext context) {
    return HydraulicCalculationScreen(
      title: 'Número de Reynolds',
      controllers: [
        _controllerVelocidad,
        _controllerDiametro,
        _controllerCinematica,
      ],
      values: calculationsController.numeroReynolds,
      inputLabels: ['Velocidad', 'Diámetro', 'V. Cinemática'],
      calculateMethod: calcularNumerodeReynolds,
      nextRoute: '/hidraulica/calculoshidraulicos/factorfriccion',
      prevRoute: '/hidraulica/calculoshidraulicos/velocidad', image: '',
     
    );
  }
}
