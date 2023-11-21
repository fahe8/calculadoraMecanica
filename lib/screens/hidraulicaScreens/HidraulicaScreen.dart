import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';

class HidraulicaScreen extends StatefulWidget {
  const HidraulicaScreen({Key? key}) : super(key: key);

  @override
  _HidraulicaScreenState createState() => _HidraulicaScreenState();
}

class _HidraulicaScreenState extends State<HidraulicaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15102C),
      appBar: MyAppBar(
          title: 'Hidráulica',
          backgroundColor: Colors.orange,
          routeBack: () {
            Navigator.pushNamed(context, '/home');
          }),
      body: Column(children: [
        Image.asset(
          'assets/hidraulica.png',
          width: 200,
          height: 200,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              CustomRectangle(
                width: double.infinity,
                height: 50,
                color: Colors.orange,
                text: 'Cálculos Hidráulicos',
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/hidraulica/calculoshidraulicos');
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomRectangle(
                width: double.infinity,
                height: 50,
                color: Colors.orange,
                text: 'Propiedades',
                onPressed: () {
                  Navigator.pushNamed(context, '/hidraulica/propiedades');
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomRectangle(
                width: double.infinity,
                height: 50,
                color: Colors.orange,
                text: 'Formulario',
                onPressed: () {
                  Navigator.pushNamed(context, '/hidraulica/formulario');
                },
              )
            ],
          ),
        ))
      ]),
    );
  }
}
