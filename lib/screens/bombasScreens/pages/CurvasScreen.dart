import 'dart:math';

import 'package:calculator/controllers/bombaController.dart';
import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/screens/bombasScreens/pages/CrearBomba.dart';
import 'package:calculator/screens/bombasScreens/pages/CrearCurva.dart';
import 'package:calculator/screens/bombasScreens/pages/DetallesCurvaScreen.dart';
import 'package:calculator/screens/bombasScreens/pages/EditarBomba.dart';
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
                height: 300,
                child: Obx(
                  () => bombaController.showGraph.value
                      ? _buildGraph()
                      : _buildEmptyGraph(),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Obx(
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
                            color: Colors.blue.shade300,
                            text: 'Modificar Curva',
                            onPressed: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditarCurva()),
                              );
                            }),
                          ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  listaBombas(),
                  SizedBox(
                    height: 15,
                  ),
                  CustomRectangle(
                    width: 120,
                    height: 40,
                    color: Colors.grey.shade200,
                    text: 'Agregar Bomba',
                    size: 13,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CrearBomba()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listaBombas() {
    return Obx(() => Column(
          children: List.generate(
            bombaController.bombas.length,
            (index) {
              return Column(
                children: [
                  RectangleBombas(
                    color: ColoresApp
                        .bombaColors[index % bombaController.bombas.length],
                    text: 'Opciones Bomba ${index + 1}',
                    options: true,
                    edit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarBomba(index: index),
                        ),
                      );
                    },
                    delete: () {
                      bombaController.eliminarBombas(index);
                    },
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetallesCurvaScreen(bombaIndex: index),
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
        .map((punto) => FlSpot(punto['caudal_litros']!, punto['h']!))
        .toList();

    List<LineChartBarData> existingLineBarsData = [
      LineChartBarData(
        spots: spots,
        isCurved: true,
        color: Colors.blue,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
      LineChartBarData(
        spots: [
          FlSpot(bombaController.curvaResistente.value.Q, 0),
          FlSpot(bombaController.curvaResistente.value.Q, 190),
        ],
        isCurved: false,
        color: Colors.red,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ];

    List<LineChartBarData> dynamicLineBarsData = [];

    for (var i = 0; i < bombaController.bombas.length; i++) {
      List<FlSpot> spotsBomba = bombaController.puntosBomba
          .where((punto) =>
              punto['bomba_id'] == bombaController.bombas[i].id.toDouble())
          .map((punto) => FlSpot(punto['caudal_litros']!, punto['h']!))
          .toList();

      LineChartBarData lineChartBarData = LineChartBarData(
        spots: spotsBomba,
        isCurved: true,
        color: ColoresApp.bombaColors[i],
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      );

      dynamicLineBarsData.add(lineChartBarData);
    }

    List<FlSpot> allSpots = [];

// Agregar puntos de la curva existente
    allSpots.addAll(existingLineBarsData[0].spots);

// Agregar puntos de las bombas dinámicas
    for (var lineBarData in dynamicLineBarsData) {
      allSpots.addAll(lineBarData.spots);
    }

    double maxY =
        allSpots.map((spot) => spot.y).reduce((max, y) => y > max ? y : max);

// Añadir un margen para asegurar que todos los puntos estén dentro del rango
    double margin = 10.0;
    maxY += margin;

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
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 45,
              ),
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
        maxY: maxY,
        lineBarsData: [...existingLineBarsData, ...dynamicLineBarsData],
        clipData: FlClipData.all(),
      ),
    );
  }
}
