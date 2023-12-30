import 'package:calculator/controllers/bombaController.dart';
import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/screens/bombasScreens/pages/DetallesCurvaScreen.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:calculator/widgets/RectangleBombas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurvasScreen extends StatefulWidget {
  const CurvasScreen({Key? key}) : super(key: key);

  @override
  _CurvasScreenState createState() => _CurvasScreenState();
}

class _CurvasScreenState extends State<CurvasScreen> {
  TextEditingController _controllerValorA = TextEditingController();
  TextEditingController _controllerValorB = TextEditingController();
  TextEditingController _controllerValorC = TextEditingController();
  TextEditingController _controllerValorQ = TextEditingController();

  final BombaController bombaController = Get.put(BombaController());

  crearCurva() {
    double valorA = double.parse(_controllerValorA.text);
    double valorB = double.parse(_controllerValorB.text);
    double valorC = double.parse(_controllerValorC.text);
    double valorQ = double.parse(_controllerValorQ.text);

    BombaModel nuevaCurva =
        BombaModel(A: valorA, B: valorB, C: valorC, Q: valorQ);
    bombaController.agregarCurva(nuevaCurva);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Curvas resistentes',
        backgroundColor: ColoresApp.bombas,
        routeBack: () {
          Navigator.pushNamed(context, '/bombas');
        },
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/bomba.png',
            width: 200,
            height: 200,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRectangle(
                      width: 200,
                      height: 50,
                      color: Colors.grey.shade200,
                      text: 'Añadir nueva bomba',
                      size: 13,
                      onPressed: modalCrearCurva,
                    ),
                  ],
                ),
                listaCurvas()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget listaCurvas() {
    return Obx(() => Column(
          children: List.generate(
            bombaController.curvas.length,
            (index) {
              BombaModel curva = bombaController.curvas[index];

              return Column(
                children: [
                  RectangleBombas(
                    color: Colors.black,
                    text: 'Opciones curva ${index + 1}',
                    options: true,
                    edit: () {bombaController.modificarValoresCurva(index, 2, 2, 2, 2); },
                    delete: () { bombaController.eliminarCurva(index); },
                    onPressed: () {
                      // Navega a la pantalla de detalle usando Navigator.pushNamed
                    },
                  ),
                  SizedBox(
                      height:
                          10), // Agrega un SizedBox de 10 después de cada RectangleBombas
                ],
              );
            },
          ),
        ));
  }

  Future modalCrearCurva() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            
            content: SingleChildScrollView(
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
                    child: Text('Crear bomba'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
