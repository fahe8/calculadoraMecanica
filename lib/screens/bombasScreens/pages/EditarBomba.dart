import 'package:calculator/controllers/bombaController.dart';
import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarBomba extends StatefulWidget {
  final  index;
  const EditarBomba({ Key? key, this.index }) : super(key: key);

  @override
  _EditarBombaState createState() => _EditarBombaState();
}

class _EditarBombaState extends State<EditarBomba> {
   TextEditingController _controllerValorA = TextEditingController();
  TextEditingController _controllerValorB = TextEditingController();


  final BombaController bombaController = Get.find<BombaController>();

  EditarCurva() {
    double valorA = double.parse(_controllerValorA.text);
    double valorB = double.parse(_controllerValorB.text);

    BombaModel bombaEditada = BombaModel(A: valorA, B: valorB);

    bombaController.editarBomba(bombaEditada, widget.index);
  }

  @override
  void initState() {
    super.initState();

    // Obtén la curva seleccionada y establece los valores iniciales en los controladores de texto

    _controllerValorA.text =
        bombaController.bombas[widget.index].A.toString() ?? '';
    _controllerValorB.text =
        bombaController.bombas[widget.index].B.toString() ?? '';

 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Editar bomba',
          backgroundColor: ColoresApp.bombas,
          routeBack: () {
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
    );
  }
}