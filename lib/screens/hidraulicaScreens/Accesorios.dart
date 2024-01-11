import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/controllers/utils/ControllerUtils.dart';
import 'package:calculator/screens/hidraulicaScreens/CalculosScreen.dart';
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
  TextEditingController _controllerCaudal = TextEditingController();
  TextEditingController _controllerDiametro = TextEditingController();


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
      controller: _controllerCaudal,
      controllerValue: calculationsController.caudal,
      calculationsController: calculationsController,
    );

    ControllerUtils.initializeAndListenController(
      controller: _controllerDiametro,
      controllerValue: calculationsController.diametro,
      calculationsController: calculationsController,
    );
  }

  @override
  void dispose() {
  
    _controllerCoeficienteK.dispose();
    _controllerCaudal.dispose();
    _controllerDiametro.dispose();
    super.dispose();
  }

  void calcularPerdidasDeAccesorios() {
    
    calculationsController.calcularPerdidasAccesorios();
  }

  @override
 Widget build(BuildContext context) {
    return HydraulicCalculationScreen(
      title: 'Pérdidas: Accesorios',
      controllers: [
        _controllerCoeficienteK,
        _controllerCaudal,
        _controllerDiametro
      ],
      values: calculationsController.perdidasAccesorios,
      inputLabels: ['Coeficiente K', 'Caudal', 'Diametro'],
      calculateMethod: calcularPerdidasDeAccesorios,
      prevRoute: '/hidraulica/calculoshidraulicos/longitudtuberia',
    );
  }
}
