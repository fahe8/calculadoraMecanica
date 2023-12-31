import 'package:calculator/controllers/bombaController.dart';
import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/screens/bombasScreens/pages/calculosBombasScreen/BombaSerie.dart';
import 'package:calculator/screens/bombasScreens/pages/calculosBombasScreen/NuevaCurva.dart';
import 'package:calculator/screens/bombasScreens/pages/calculosBombasScreen/ScreenDetalles.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:calculator/widgets/RectangleBombas.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetallesCurvaScreen extends StatefulWidget {
  final int bombaIndex;
  const DetallesCurvaScreen({Key? key, required this.bombaIndex})
      : super(key: key);

  @override
  _DetallesCurvaScreenState createState() => _DetallesCurvaScreenState();
}

class _DetallesCurvaScreenState extends State<DetallesCurvaScreen> {
  final BombaController bombaController = Get.find<BombaController>();

  void generarVariador() {
    bombaController.variadorDeFrecuencia(widget.bombaIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Bomba #${widget.bombaIndex + 1}',
          backgroundColor: ColoresApp.bombas,
          routeBack: () {
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RectangleBombas(
              color: Colors.red.shade300,
              text: 'Bombas en serie',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BombaSerie(
                              title: 'Bombas en serie',
                              indexBomba: widget.bombaIndex,
                            )));
              },
            ),
            SizedBox(height: 10),
            RectangleBombas(
                color: Colors.blue.shade300, text: 'Bombas en Paralelo'),
            SizedBox(height: 10),
            RectangleBombas(
              color: Colors.green.shade300,
              text: 'Variador de frecuencia',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenDetalles(
                              title: 'Variador de frecuencia',
                              indexBomba: widget.bombaIndex,
                            )));
              },
            ),
            SizedBox(height: 10),
            RectangleBombas(
                color: Colors.purple.shade300, text: 'Corte de Rodete'),
            SizedBox(height: 10),
            RectangleBombas(
              color: Colors.orange.shade300,
              text: 'Nueva Curva Resistente',
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NuevaCurva(
                              title: 'Variador de frecuencia',
                              indexBomba: widget.bombaIndex,
                            )));
              }),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
