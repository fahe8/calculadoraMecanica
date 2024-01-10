import 'package:calculator/controllers/bombaController.dart';
import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:calculator/widgets/RectangleBombas.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NuevaCurva extends StatefulWidget {
  final String title;
  final int indexBomba;

  const NuevaCurva({
    Key? key,
    required this.title,
    required this.indexBomba,
  }) : super(key: key);

  @override
  _NuevaCurvaState createState() => _NuevaCurvaState();
}

class _NuevaCurvaState extends State<NuevaCurva> {
  final BombaController bombaController = Get.find<BombaController>();

  int selectedBombaIndex = 0;
  late List<int> bombaIndices;
  late List<FlSpot> bombaPuntos = [];
  String aumentarDisminuir = 'aumentar';
  late Map<String, dynamic> hallarResultado;
  @override
  void initState() {
    super.initState();

    bombaIndices =
        List.generate(bombaController.bombas.length, (index) => index);
    selectedBombaIndex = widget.indexBomba;

    _initializeBombaPuntos();
  }

  Future<void> _initializeBombaPuntos() async {
    bombaPuntos =
        await bombaController.obtenerPuntosDeBomba(selectedBombaIndex);
         hallarResultado = bombaController.formulasHallar(
      widget.indexBomba,
      TipoCurva.NUEVACURVA,
      aumentarDisminuir,
    );
    setState(
        () {}); // Esto fuerza a redibujar el widget con los datos actualizados
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: ColoresApp.bombas,
        title: widget.title,
        routeBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 16, right: 16),
            height: 300,
            child: _buildGraph(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                curvasIdentificador(Colors.blue, 'Curva Resistente'),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text('Seleccionar Bomba:'),
                    SizedBox(width: 10),
                    DropdownButton<int>(
                      value: selectedBombaIndex,
                      items: bombaIndices
                          .map((index) => DropdownMenuItem<int>(
                                value: index,
                                child: Text('Bomba #${index + 1}'),
                              ))
                          .toList(),
                      onChanged: (newIndex) async {
                        setState(() {
                          selectedBombaIndex = newIndex!;
                        });
                        await _initializeBombaPuntos();
                      },
                    ),
                  ],
                ),
                curvasIdentificador(ColoresApp.bombaColors[selectedBombaIndex],
                    'Bomba #${selectedBombaIndex + 1}'),
                SizedBox(
                  height: 8,
                ),
                curvasIdentificador(Colors.pink, 'Nueva Curva Resistente'),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          aumentarDisminuir = 'aumentar';
                        });
                      },
                      child: Text('Aumentar'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          aumentarDisminuir = 'disminuir';
                        });
                      },
                      child: Text('Disminuir'),
                    ),
                  ],
                ),
                buildResultRow()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget curvasIdentificador(Color color, String text) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  Widget buildResultRow() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(15)),
      width: double.infinity,
      child: Row(
        children: [
          CustomRectangle(
            height: 50,
            color: Colors.pink,
            text: 'K',
            size: 15,
            width: 130,
          ),
          Expanded(
                child: Container(
              height: 50,
              child: Center(
                child: Text(
                  hallarResultado['resultado']
                      .toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )),
          
        ],
      ),
    );
  }

  LineChart _buildGraph() {
    List<LineChartBarData> existingLineBarsData = _buildLineBarsData();

    List<FlSpot> allSpots = [];
    existingLineBarsData.forEach(
      (barData) => allSpots.addAll(barData.spots),
    );

    double maxY =
        allSpots.map((spot) => spot.y).reduce((max, y) => y > max ? y : max);

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
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black),
        ),
        minX: 0,
        maxX: 40,
        minY: 0,
        maxY: maxY,
        lineBarsData: existingLineBarsData,
        clipData: FlClipData.all(),
      ),
    );
  }

  List<LineChartBarData> _buildLineBarsData() {
    List<FlSpot> spots = bombaController.puntosCurva
        .map((punto) => FlSpot(punto['caudal_litros']!, punto['h']!))
        .toList();

    List<FlSpot> spotsVariador = (hallarResultado['puntos']
            as List<Map<String, double>>)
        .map((punto) => FlSpot(punto['caudal_litros']!, punto['h']!))
        .toList();

    return [
      _buildLineBarData(spots, Colors.blue),
      _buildLineBarData(spotsVariador, Colors.pink),
      _buildLineBarData(
          bombaPuntos, ColoresApp.bombaColors[selectedBombaIndex]),
      _buildLineBarData(
        [
          FlSpot(bombaController.curvaResistente.value.Q, 0),
          FlSpot(bombaController.curvaResistente.value.Q, bombaController.curvaResistente.value.A + 20),
        ],
        Colors.red,
      ),
    ];
  }

  LineChartBarData _buildLineBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }
}
