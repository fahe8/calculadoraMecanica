import 'package:calculator/controllers/utils/Colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

class InterpoladorScreen extends StatefulWidget {
  const InterpoladorScreen({Key? key}) : super(key: key);

  @override
  _InterpoladorScreenState createState() => _InterpoladorScreenState();
}

class _InterpoladorScreenState extends State<InterpoladorScreen> {
  final TextEditingController _controllerX0 = TextEditingController();
  final TextEditingController _controllerY0 = TextEditingController();
  final TextEditingController _controllerX1 = TextEditingController();
  final TextEditingController _controllerY1 = TextEditingController();
  final TextEditingController _controllerX = TextEditingController();
  final TextEditingController _controllerY = TextEditingController();

  bool _showGraph = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interpolador'),
        backgroundColor: ColoresApp.interpolador,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                height: 300,
                child: _showGraph ? _buildGraph() : _buildEmptyGraph(),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: ColoresApp.greyShade,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  Row(
                   
                    children: [
                      rectanguloCoordenada('X0', _controllerX0),
                      SizedBox(
                        width: 10,
                      ),
                      rectanguloCoordenada('Y0', _controllerY0),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                   
                    children: [
                      rectanguloCoordenada('X', _controllerX),
                      SizedBox(
                        width: 10,
                      ),
                      rectanguloCoordenada('Y', _controllerY),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    
                    children: [
                      rectanguloCoordenada('X1', _controllerX1),
                      SizedBox(
                        width: 10,
                      ),
                      rectanguloCoordenada('Y1', _controllerY1),
                    ],
                  ),
                ]),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showGraph = false;
                        _controllerX0.clear();
                        _controllerY0.clear();
                        _controllerX1.clear();
                        _controllerY1.clear();
                        _controllerX.clear();
                        _controllerY.clear();
                      });
                    },
                    child: Text('Reiniciar'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showGraph = true;
                      });
                    },
                    child: Text('Calcular y Mostrar Gráfico'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChart _buildGraph() {
    final x0 = double.tryParse(_controllerX0.text) ?? 0;
    final y0 = double.tryParse(_controllerY0.text) ?? 0;
    final x1 = double.tryParse(_controllerX1.text) ?? 0;
    final y1 = double.tryParse(_controllerY1.text) ?? 0;
    final x = double.tryParse(_controllerX.text) ?? 0;
    final y = ((y1 - y0) / (x1 - x0)) * (x - x0) + y0;

    final minX = [x0, x, x1].reduce((min, value) => min > value ? value : min);
    final maxX = [x0, x, x1].reduce((max, value) => max < value ? value : max);
    final minY = [y0, y, y1].reduce((min, value) => min > value ? value : min);
    final maxY = [y0, y, y1].reduce((max, value) => max < value ? value : max);

    print('resultado Y ${y}');

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          
        ),
        
        gridData: FlGridData(show: true),
        titlesData: const FlTitlesData(
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
          
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
            ),
          ),
         
        ),
        minX: minX - 2,
        maxX: maxX + 2,
        minY: minY - 2,
        maxY: maxY + 2,
        lineBarsData: [
          interpolateLineData(),
        ],
      ),
    );
  }

  LineChartBarData interpolateLineData() {
    final x0 = double.tryParse(_controllerX0.text) ?? 0;
    final y0 = double.tryParse(_controllerY0.text) ?? 0;
    final x1 = double.tryParse(_controllerX1.text) ?? 0;
    final y1 = double.tryParse(_controllerY1.text) ?? 0;
    final x = double.tryParse(_controllerX.text) ?? 0;

    // Realiza la interpolación lineal
    final y = ((y1 - y0) / (x1 - x0)) * (x - x0) + y0;
    _controllerY.text = y.toString();

    return LineChartBarData(
      spots: [
        FlSpot(x0, y0),
        FlSpot(x, y),
        FlSpot(x1, y1),
      ],
      isCurved: true,
      color: Colors.blue,
      dotData: FlDotData(show: true,),
      belowBarData: BarAreaData(show: false),

    );
  }

  LineChart _buildEmptyGraph() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
       titlesData: const FlTitlesData(
          rightTitles:  AxisTitles(
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

  Widget rectanguloCoordenada(String coord, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.455,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            width: 40,
            child: Center(child: Text(coord)),
          ),
          Expanded(
            
            child: TextField(
              enabled: controller == _controllerY ? false : true,
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: Icon(Icons.clear),
                ),
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
