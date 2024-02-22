import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:calculator/widgets/lectorPdf.dart';
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
  
      appBar: MyAppBar(
          title: 'Hidráulica',
          backgroundColor: ColoresApp.hidraulica,
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
                color: ColoresApp.hidraulica,
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
                color: ColoresApp.hidraulica,
                text: 'Propiedades',
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LectorPdf(selectedPdfKey: 'propiedades',),
                        )
                      );
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomRectangle(
                width: double.infinity,
                height: 50,
                color: ColoresApp.hidraulica,
                text: 'Formulario',
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LectorPdf(selectedPdfKey: 'fHidraulica',),
                        )
                      );
                },
              )
            ],
          ),
        ))
      ]),
    );
  }
}
