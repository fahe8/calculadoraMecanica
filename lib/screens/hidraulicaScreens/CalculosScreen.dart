import 'package:calculator/controllers/utils/Colores.dart';
import 'package:calculator/widgets/CustomInput.dart';
import 'package:calculator/widgets/CustomRectangle.dart';
import 'package:calculator/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HydraulicCalculationScreen extends StatelessWidget {
  final String title;
  final List<TextEditingController> controllers;
  final RxDouble values;
  final List<String> inputLabels;
  final VoidCallback calculateMethod;
  final String? nextRoute;
  final String? prevRoute;
  final String image;

  const HydraulicCalculationScreen({
    Key? key,
    required this.title,
    required this.controllers,
    required this.values,
    required this.inputLabels,
    required this.calculateMethod,
    this.nextRoute,
    this.prevRoute,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        backgroundColor: ColoresApp.hidraulica,
        routeBack: () {
          Navigator.pushNamed(context, '/hidraulica/calculoshidraulicos');
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
               image,
                width: 290,
                height: 160,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 40,
              ),
              for (int i = 0; i < controllers.length; i++)
                Column(
                  children: [
                    CustomInput(
                      color: ColoresApp.hidraulica,
                      text: inputLabels[i],
                      size: 15,
                      controller: controllers[i],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              buildResultRow(),
              SizedBox(height: 20),
              buildCalculateButton(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prevRoute != null) buildPrevButton(context),
                  if (prevRoute != null && nextRoute != null)
                    SizedBox(width: 20),
                  if (nextRoute != null) buildNextButton(context),
                ],
              )
            ],
          ),
        ),
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
            color: ColoresApp.hidraulica,
            text: 'Resultado',
            size: 15,
            width: 130,
          ),
          Obx(
            () => Expanded(
                child: Container(
              height: 50,
              child: Center(
                child: Text(
                  values.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )),
          )
        ],
      ),
    );
  }

  Widget buildCalculateButton() {
    return ElevatedButton(
      onPressed: () {
        calculateMethod();
      },
      child: Text(
        'CALCULAR',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColoresApp.hidraulica)),
      onPressed: () {
        Navigator.pushNamed(context, nextRoute!);
      },
      child: Text('SIGUIENTE', style: TextStyle(color: Colors.black)),
    );
  }

  Widget buildPrevButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, prevRoute!);
      },
      child: Text('ANTERIOR', style: TextStyle(color: Colors.black)),
    );
  }
}
