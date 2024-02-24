import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';

class CalculosHidraulicosScreen extends StatelessWidget {
  const CalculosHidraulicosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Cálculos hidráulicos',
          backgroundColor: ColoresApp.hidraulica,
          routeBack: () {
            Navigator.pushNamed(context, '/hidraulica');
          }),
      body: Container(

        child: Column(children: [
          Image.asset(
            'assets/hidraulica.png',
            width: 200,
            height: 200,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                CustomRectangle(
                  width: double.infinity,
                  height: 50,
                  color: ColoresApp.hidraulica,
                  text: 'Velocidad',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/hidraulica/calculoshidraulicos/velocidad');
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomRectangle(
                  width: double.infinity,
                  height: 50,
                  color: ColoresApp.hidraulica,
                  text: 'Número de Reynolds',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/hidraulica/calculoshidraulicos/reynolds');
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomRectangle(
                  width: double.infinity,
                  height: 50,
                  color: ColoresApp.hidraulica,
                  text: 'Factor de Fricción',
                  onPressed: () {
                    Navigator.pushNamed(context,
                        '/hidraulica/calculoshidraulicos/factorfriccion');
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomRectangle(
                  width: double.infinity,
                  height: 50,
                  color: ColoresApp.hidraulica,
                  text: 'Pérdidas: Longitud de tuberia',
                  onPressed: () {
                    Navigator.pushNamed(context,
                        '/hidraulica/calculoshidraulicos/longitudtuberia');
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomRectangle(
                  width: double.infinity,
                  height: 50,
                  color: ColoresApp.hidraulica,
                  text: 'Pérdidas: Accesorios',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/hidraulica/calculoshidraulicos/accesorios');
                  },
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
