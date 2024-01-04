import 'package:calculator/controllers/bombaController.dart';
import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarCurva extends StatefulWidget {
  const EditarCurva({
    Key? key,
  }) : super(key: key);

  @override
  _EditarCurvaState createState() => _EditarCurvaState();
}

class _EditarCurvaState extends State<EditarCurva> {
  TextEditingController _controllerValorA = TextEditingController();
  TextEditingController _controllerValorB = TextEditingController();
  TextEditingController _controllerValorQ = TextEditingController();

  final BombaController bombaController = Get.find<BombaController>();

  EditarCurva() {
    double valorA = double.parse(_controllerValorA.text);
    double valorB = double.parse(_controllerValorB.text);

    double valorQ = double.parse(_controllerValorQ.text);

    CurvaModel nuevaCurva = CurvaModel(A: valorA, B: valorB, Q: valorQ);
    bombaController.editarCurva(nuevaCurva);
  }

  @override
  void initState() {
    super.initState();

    // Obtén la curva seleccionada y establece los valores iniciales en los controladores de texto

    _controllerValorA.text =
        bombaController.curvaResistente.value.A.toString() ?? '';
    _controllerValorB.text =
        bombaController.curvaResistente.value.B.toString() ?? '';

    _controllerValorQ.text =
        bombaController.curvaResistente.value.Q.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Editar curva',
          backgroundColor: ColoresApp.bombas,
          routeBack: () {
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInput(
                color: Colors.blue,
                text: 'A',
                size: 13,
                width: 50,
                controller: _controllerValorA,
              ),
              SizedBox(
                height: 15,
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
                  EditarCurva();
                  Navigator.pop(context);
                },
                child: Text('Editar bomba'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
