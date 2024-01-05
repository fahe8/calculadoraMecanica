import 'package:calculator/controllers/bombaController.dart';
import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrearCurva extends StatefulWidget {
  const CrearCurva({Key? key}) : super(key: key);

  @override
  _CrearCurvaState createState() => _CrearCurvaState();
}

class _CrearCurvaState extends State<CrearCurva> {
  TextEditingController _controllerValorA = TextEditingController();
  TextEditingController _controllerValorB = TextEditingController();

  TextEditingController _controllerValorQ = TextEditingController();

  final BombaController bombaController = Get.find<BombaController>();

  crearCurva() {
    double valorA = double.parse(_controllerValorA.text);
    double valorB = double.parse(_controllerValorB.text);

    double valorQ = double.parse(_controllerValorQ.text);

    bombaController.crearCurva(valorA, valorB, valorQ);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Crear curva',
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
                'assets/bomba_Curva.png',
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
                text: 'Q',
                size: 13,
                width: 50,
                controller: _controllerValorQ,
              ),
              ElevatedButton(
                onPressed: () {
                  crearCurva();
                  Navigator.pop(context);
                },
                child: Text('Crear curva'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
