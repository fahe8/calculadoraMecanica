import 'package:calculator/screens/SplashScreen.dart';
import 'package:calculator/screens/bombasScreens/BombasScreen.dart';
import 'package:calculator/screens/hidraulicaScreens/Accesorios.dart';
import 'package:calculator/screens/hidraulicaScreens/CalculosHidraulicosScreen.dart';
import 'package:calculator/screens/hidraulicaScreens/FactorFriccion.dart';

import 'package:calculator/screens/hidraulicaScreens/HidraulicaScreen.dart';
import 'package:calculator/screens/hidraulicaScreens/LongitudTuberia.dart';
import 'package:calculator/screens/hidraulicaScreens/NumeroReynolds.dart';
import 'package:calculator/screens/hidraulicaScreens/Velocidad.dart';
import 'package:flutter/material.dart';

void main() {
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
        '/hidraulica': (context) => HidraulicaScreen(),
        '/hidraulica/calculoshidraulicos': (context) =>
            CalculosHidraulicosScreen(),
        '/hidraulica/calculoshidraulicos/velocidad': (context) => Velocidad(),
        '/hidraulica/calculoshidraulicos/reynolds': (context) => NumeroReynolds(),
        '/hidraulica/calculoshidraulicos/factorfriccion': (context) => FactorFriccion(),
        '/hidraulica/calculoshidraulicos/longitudtuberia': (context) => LongitudTuberia(),
        '/hidraulica/calculoshidraulicos/accesorios': (context) => Accesorios(),
        '/bombas': (context) => BombasScreen(),
        // '/interpolador': (context) => InterpoladorScreen(),
        // '/tutoriales': (context) => TutorialesScreen(),
      },
    );
  }
}
