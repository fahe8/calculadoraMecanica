import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/screens/bombasScreens/pages/BombasSerie.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:calculator/widgets/RectangleBombas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetallesBoma extends StatefulWidget {
  final int? index;
  const DetallesBoma({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  _DetallesBomaState createState() => _DetallesBomaState();
}

class _DetallesBomaState extends State<DetallesBoma> {
  TextEditingController _controllerValorA = TextEditingController();
  TextEditingController _controllerValorB = TextEditingController();
  TextEditingController _controllerValorC = TextEditingController();
  TextEditingController _controllerValorQ = TextEditingController();

  Bomba bomba = Bomba(caudal: 0.0, valorA: 0.0, valorB: 0.0);

  final CalculationsController calculationsController =
      Get.find<CalculationsController>();

  @override
  void initState() {
    super.initState();

    // Obtén la bomba usando el índice y llénala en los controladores de texto
    bomba = calculationsController.obtenerBomba(widget.index!);

    _controllerValorA.text = bomba.valorA.toString();
    _controllerValorB.text = bomba.valorB.toString();
    _controllerValorC.text = bomba.valorC.toString();
    _controllerValorQ.text = bomba.caudal.toString();
  }

  void modificarBomba() {
    // Obtén los valores de los controladores
    double valorA = double.parse(_controllerValorA.text);
    double valorB = double.parse(_controllerValorB.text);
    double valorC = double.parse(_controllerValorC.text);
    double valorQ = double.parse(_controllerValorQ.text);

// Llama al método crearNuevaBomba en CalculationsController
    calculationsController.actualizarBomba(
        widget.index!, valorA, valorB, valorQ);
  }

  void mostrarVentanaModalModificarBomba() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Modifica los valores'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de A',
                    hintText: 'Valor A...',
                    size: 13,
                    width: 100,
                    controller: _controllerValorA,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de B',
                    hintText: 'Valor B...',
                    size: 13,
                    width: 100,
                    controller: _controllerValorB,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de C',
                    hintText: 'Valor C...',
                    size: 13,
                    width: 100,
                    controller: _controllerValorC,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomInput(
                    color: Colors.blue,
                    text: 'Valor de Q',
                    hintText: 'Valor Q...',
                    size: 13,
                    width: 100,
                    controller: _controllerValorQ,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      modificarBomba();
                      Navigator.pop(context);
                    },
                    child: Text('Modificar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
void mostrarVentanaModalCurva() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Resultado de Curva Resistente'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            
                
                ElevatedButton(
                  onPressed: () {
                 
                    Navigator.pop(context);
                  },
                  child: Text('Listo'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar: MyAppBar(
          title: 'Bomba #${widget.index != null ? widget.index! + 1 : ''}',
          backgroundColor: Colors.blue,
          routeBack: () {
            Navigator.pushNamed(context, '/bombas/seleccionBombas');
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/bomba.png',
              width: 200,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    '¿Que quieres calcular?',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RectangleBombas(
                    color: Colors.orange,
                    text: 'Modificar Valores',
                    onPressed: () {
                      mostrarVentanaModalModificarBomba();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RectangleBombas(
                    color: Colors.orange,
                    text: 'Curva Resistente',
                    onPressed: () {
                      mostrarVentanaModalCurva();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RectangleBombas(
                      color: Colors.red,
                      text: 'Bombas en Serie',
                      onPressed: () {
                        Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BombasSerie(bomba: bomba),
                                      ),
                                    );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  RectangleBombas(
                      color: Colors.blue,
                      text: 'Bombas en Paralelo',
                      onPressed: () {
                        mostrarVentanaModalModificarBomba();
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  RectangleBombas(
                      color: Colors.lightGreen,
                      text: 'Variador de Frecuencia',
                      onPressed: () {
                        mostrarVentanaModalModificarBomba();
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  RectangleBombas(
                      color: Colors.purple,
                      text: 'Corte de Rodete',
                      onPressed: () {
                        mostrarVentanaModalModificarBomba();
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  RectangleBombas(
                      color: Colors.yellow,
                      text: 'Nueva Curva Resistente',
                      onPressed: () {
                        mostrarVentanaModalModificarBomba();
                      }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
