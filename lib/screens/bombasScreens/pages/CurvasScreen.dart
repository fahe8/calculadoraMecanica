import 'package:calculator/controllers/bombaController.dart';
import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/screens/bombasScreens/pages/CrearCurva.dart';
import 'package:calculator/screens/bombasScreens/pages/DetallesCurvaScreen.dart';
import 'package:calculator/screens/bombasScreens/pages/EditarCurva.dart';

import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:calculator/widgets/RectangleBombas.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurvasScreen extends StatefulWidget {
  const CurvasScreen({Key? key}) : super(key: key);

  @override
  _CurvasScreenState createState() => _CurvasScreenState();
}

class _CurvasScreenState extends State<CurvasScreen> {
  final BombaController bombaController = Get.put(BombaController());

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 16, right: 16),
                height: 400,
                child: Obx(
                  () => bombaController.showGraph.value
                      ? _buildGraph()
                      : _buildEmptyGraph(),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => bombaController.curvaResistente.value.A == 0 &&
                        bombaController.curvaResistente.value.B == 0 &&
                        bombaController.curvaResistente.value.Q == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomRectangle(
                            width: 200,
                            height: 50,
                            color: Colors.grey.shade200,
                            text: 'Añadir curva Resistente',
                            size: 13,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CrearCurva()),
                              );
                            },
                          )
                        ],
                      )
                    : RectangleBombas(
                        color: Colors.orange.shade300, text: 'Modificar Curva'),
              ),
            ),
            CustomRectangle(
              width: 120,
              height: 40,
              color: Colors.grey.shade200,
              text: 'Agregar Bomba',
              size: 13,
              onPressed: () {},
            ),
            SizedBox(
              height: 15,
            ),
            listaCurvas()
          ],
        ),
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
                    edit: () {},
                    delete: () {},
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetallesCurvaScreen(curvaIndex: index),
                        ),
                      );
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

  LineChart _buildEmptyGraph() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: const FlTitlesData(
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black),
        ),
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 10,
        lineBarsData: [],
      ),
    );
  }

  LineChart _buildGraph() {
    List<FlSpot> spots = bombaController.puntosCurva
        .map((punto) => FlSpot(punto['caudal_litros']!, punto['HR']!))
        .toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: const FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              axisNameWidget: Text('Altura (mca)'),
              sideTitles:
                  SideTitles(showTitles: true, reservedSize: 35, interval: 20),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: Text('Caudal (l/s)'),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
              ),
            )),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black),
        ),
        minX: 0,
        maxX: 40,
        minY: 0,
        maxY: 200,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: [
              FlSpot(30, 0),
              // FlSpot(30, 190),
              FlSpot(30, 190),
            ],
            isCurved: false,
            color: Colors.red,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          )
        ],
      ),
    );
  }
}
