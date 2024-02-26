import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/screens/hidraulicaScreens/CalculosScreen.dart';
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
    return HydraulicCalculationScreen(
      title: 'Pérdidas: Longitud de Tuberia',
      controllers: [
        _controllerFriccion,
        _controllerLongitud,
        _controllerCaudal,
        _controllerDiametro,
      ],
      values: calculationsController.perdidasLongitudTuberia,
      inputLabels: [
        'F. Fricción',
        'Longitud',
        'Caudal',
        'Diámetro',
      ],
      calculateMethod: calcularPerdidasDeLongitudTuberia,
      nextRoute: '/hidraulica/calculoshidraulicos/accesorios',
      prevRoute: '/hidraulica/calculoshidraulicos/factorfriccion', image: '',
    );
  }
}
