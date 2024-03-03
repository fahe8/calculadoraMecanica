import 'package:calculator/controllers/CalculationsController.dart';
import 'package:calculator/screens/Home.dart';
import 'package:calculator/screens/SplashScreen.dart';
import 'package:calculator/screens/bombasScreens/BombasScreen.dart';
import 'package:calculator/screens/bombasScreens/pages/CurvasScreen.dart';
import 'package:calculator/screens/hidraulicaScreens/Accesorios.dart';
import 'package:calculator/screens/hidraulicaScreens/CalculosHidraulicosScreen.dart';
import 'package:calculator/screens/hidraulicaScreens/FactorFriccion.dart';

import 'package:calculator/screens/hidraulicaScreens/HidraulicaScreen.dart';
import 'package:calculator/screens/hidraulicaScreens/LongitudTuberia.dart';
import 'package:calculator/screens/hidraulicaScreens/NumeroReynolds.dart';
import 'package:calculator/screens/hidraulicaScreens/Velocidad.dart';
import 'package:calculator/screens/interpolador/InterpoladorScreen.dart';
import 'package:calculator/screens/tutoriales/ScreenTutoriales.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(CalculationsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/home': (context) => Home(),
        '/hidraulica': (context) => HidraulicaScreen(),
        '/hidraulica/calculoshidraulicos': (context) =>
            CalculosHidraulicosScreen(),
        '/hidraulica/calculoshidraulicos/velocidad': (context) => Velocidad(),
        '/hidraulica/calculoshidraulicos/reynolds': (context) =>
            NumeroReynolds(),
        '/hidraulica/calculoshidraulicos/factorfriccion': (context) =>
            FactorFriccion(),
        '/hidraulica/calculoshidraulicos/longitudtuberia': (context) =>
            LongitudTuberia(),
        '/hidraulica/calculoshidraulicos/accesorios': (context) => Accesorios(),
        '/bombas': (context) => BombasScreen(),
       '/bombas/seleccionBombas': (context) => CurvasScreen(),


        '/interpolador': (context) => InterpoladorScreen(),
        '/tutoriales': (context) => VideoList(),
      },
    );
  }
}
