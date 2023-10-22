import 'package:calculator/controllers/CalculationsController.dart';
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

    // Agrega un listener al _controllerCaudal para escuchar cambios en el TextField
    _controllerCaudal.addListener(() {
      // Cuando cambie el valor en el TextField, actualiza el valor en CalculationsController
      calculationsController.caudal.value =
          double.tryParse(_controllerCaudal.text) ?? 0.0;
    });
    _controllerDiametro.addListener(() {
      // Cuando cambie el valor en el TextField, actualiza el valor en CalculationsController
      calculationsController.diametro.value =
          double.tryParse(_controllerDiametro.text) ?? 0.0;
    });
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Resultado del cálculo'),
          content: Text(
              'Velocidad calculada: ${calculationsController.velocidad} m/s'),
          // content: Text('Caudal: ${calculationsController.caudal1} y  Diametro ${calculationsController.diametro}'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar: MyAppBar(title: 'Velocidad', backgroundColor: Colors.green),
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
                    color: Colors.green,
                    text: 'Caudal (m³/s)',
                    hintText: 'Escribe el Caudal',
                    size: 15,
                    controller: _controllerCaudal),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                    color: Colors.green,
                    text: 'Diámetro (m)',
                    hintText: 'Escribe el diametro',
                    size: 15,
                    controller: _controllerDiametro),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRectangle(
                      width: 80,
                      height: 30,
                      color: Colors.green,
                      text: 'Resultado',
                      size: 15,
                    ),
                    CustomRectangle(
                      width: 180,
                      height: 30,
                      color: Colors.grey.shade300,
                      text: calculationsController.velocidad.toString(),
                      size: 15,
                    ),
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
                        color: Colors.grey.shade300,
                        text: 'Calcular',
                        size: 13,
                        onPressed: calcularVelocidad),
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
