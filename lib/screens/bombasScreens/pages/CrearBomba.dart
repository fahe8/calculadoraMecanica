import 'package:calculator/controllers/bombaController.dart';
import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrearBomba extends StatelessWidget {
  TextEditingController _controllerValorA = TextEditingController();
  TextEditingController _controllerValorB = TextEditingController();
  TextEditingController _controllerValorC = TextEditingController();

  final BombaController bombaController = Get.find<BombaController>();

  agregarNuevaBomba() {
   double valorA = double.parse(_controllerValorA.text);
    double valorB = _controllerValorB.text.isNotEmpty ? double.parse(_controllerValorB.text) : 0;
    double valorC = _controllerValorC.text.isNotEmpty ? double.parse(_controllerValorC.text) : 0;

    BombaModel nuevaBomba = BombaModel(A: valorA, B: valorB, C: valorC);

    bombaController.agregarBomba(nuevaBomba);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Crear Bomba',
          backgroundColor: ColoresApp.bombas,
          routeBack: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/bomba.png',
                width: 200,
                height: 200,
              ),
              CustomInput(
                color: Colors.blue,
                text: 'A',
                size: 13,
                width: 50,
                controller: _controllerValorA,
              ),
              SizedBox(
                height: 20,
              ),
              CustomInput(
                color: Colors.blue,
                text: 'B',
                size: 13,
                width: 50,
                controller: _controllerValorB,
              ),
              SizedBox(
                height: 20,
              ),
              CustomInput(
                color: Colors.blue,
                text: 'C',
                size: 13,
                width: 50,
                controller: _controllerValorC,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  agregarNuevaBomba();
                  Navigator.pop(context);
                },
                child: Text('Agregar Bomba'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
