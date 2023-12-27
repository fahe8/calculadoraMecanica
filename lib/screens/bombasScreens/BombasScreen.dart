import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';

class BombasScreen extends StatelessWidget {
  const BombasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Bomba',
          backgroundColor: Colors.blue,
          routeBack: () {
           Navigator.pushNamed(context, '/home');
          }),
      body: Container(
        child: Column(children: [
          Image.asset(
            'assets/bomba.png',
            width: 200,
            height: 200,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomRectangle(
                  width: double.infinity,
                  height: 50,
                  color: Colors.blue,
                  text: 'Selección de Bombas',
                  onPressed: () {Navigator.pushNamed(context, '/bombas/seleccionBombas');},
                ),
                CustomRectangle(
                  width: double.infinity,
                  height: 50,
                  color: Colors.blue,
                  text: 'Propiedades',
                  onPressed: () {},
                ),
                CustomRectangle(
                  width: double.infinity,
                  height: 50,
                  color: Colors.blue,
                  text: 'Formulario',
                  onPressed: () {},
                )
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
