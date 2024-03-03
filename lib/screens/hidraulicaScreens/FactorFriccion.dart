import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/screens/hidraulicaScreens/CalculosScreen.dart';
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
    return HydraulicCalculationScreen(
      title: 'Factor de Fricción',
      controllers: [
        _controllerRugosidad,
        _controllerDiametro,
        _controllerReynolds,
      ],
      values: calculationsController.factorFriccion,
      inputLabels: ['Rugosidad', 'Diámetro', 'Núm. Reynolds'],
      calculateMethod: calcularFactorDeFriccion,
      nextRoute: '/hidraulica/calculoshidraulicos/longitudtuberia',
      prevRoute: '/hidraulica/calculoshidraulicos/reynolds', image: 'assets/friccion.png',
    );
  }
}
