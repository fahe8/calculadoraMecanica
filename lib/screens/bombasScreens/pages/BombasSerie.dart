// import 'package:calculator/controllers/CalculationsController.dart';
// import 'package:calculator/widgets/CustomBombaCalculation.dart';
// import 'package:calculator/widgets/CustomInput.dart';
// import 'package:calculator/widgets/CustomRectangle.dart';
// import 'package:calculator/widgets/MyAppBar.dart';
// import 'package:flutter/material.dart';

// class BombasSerie extends StatefulWidget {
//   final Map bomba;
//   const BombasSerie({Key? key, required this.bomba,}) : super(key: key);

//   @override
//   State<BombasSerie> createState() => _BombasSerieState();
// }

// class _BombasSerieState extends State<BombasSerie> {
//   TextEditingController _controllerValorA = TextEditingController();

//   TextEditingController _controllerValorB = TextEditingController();

//   TextEditingController _controllerValorC = TextEditingController();

// @override
//   void initState() {
//     super.initState();
//     // Accede a los argumentos pasados y úsalos según sea necesario
//     Map detallesBomba = widget.bomba;
//     // Haz algo con los detallesBomba, por ejemplo:
//     _controllerValorA.text = detallesBomba.valorA.toString();
//     _controllerValorB.text = detallesBomba.valorB.toString();
//     // _controllerValorC.text = detallesBomba.caudal.toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF15102C),
//       appBar: MyAppBar(
//           title: 'Bomba en Serie',
//           backgroundColor: Colors.blue,
//           routeBack: () {
//             Navigator.pop(context);
//           }),
//       body: CustomBombaCalculation(onpressed: (){print('funciona');}, controllerValorA: _controllerValorA, controllerValorB: _controllerValorB, controllerValorC: _controllerValorC, image: 'assets/bomba.png')
//     );
//   }
// }
