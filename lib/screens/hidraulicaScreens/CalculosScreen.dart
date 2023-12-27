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
  final String? units;
  final List<String> inputLabels;
  final VoidCallback calculateMethod;
  final String? nextRoute;
  final String? prevRoute;

  const HydraulicCalculationScreen({
    Key? key,
    required this.title,
    required this.controllers,
    required this.values,
    required this.inputLabels,
    required this.calculateMethod,
    this.nextRoute,
    this.prevRoute,
    this.units,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        backgroundColor: Colors.orange,
        routeBack: () {
          Navigator.pushNamed(context, '/hidraulica/calculoshidraulicos');
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // ... (otros widgets comunes)
              for (int i = 0; i < controllers.length; i++)
                CustomInput(
                  color: Colors.orange,
                  text: inputLabels[i],
                  size: 15,
                  controller: controllers[i],
                ),
              SizedBox(height: 50),
              // ... (otros widgets comunes)
              buildResultRow(),
              SizedBox(height: 50),
              buildCalculateButton(),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prevRoute != null) buildPrevButton(context),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomRectangle(
          width: 80,
          height: 50,
          color: Colors.orange,
          text: 'Resultado',
          size: 15,
        ),
        Obx(
          () => CustomRectangle(
            width: 180,
            height: 50,
            color: Colors.grey.shade300,
            text: values.toString() + (units != null ? units! : ''),
            size: 18,
          ),
        )
      ],
    );
  }

  Widget buildCalculateButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomRectangle(
            width: 80,
            height: 40,
            color: Colors.grey.shade300,
            text: 'Calcular',
            size: 18,
            onPressed: calculateMethod,
          ),
        ],
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomRectangle(
            width: 80,
            height: 30,
            color: Colors.orange.shade300,
            text: 'Siguiente',
            size: 13,
            onPressed: () {
              Navigator.pushNamed(context, nextRoute!);
            },
          ),
        ],
      ),
    );
  }

  Widget buildPrevButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomRectangle(
            width: 80,
            height: 30,
            color: Colors.orange.shade300,
            text: 'Anterior',
            size: 13,
            onPressed: () {
              Navigator.pushNamed(context, prevRoute!);
            },
          ),
        ],
      ),
    );
  }
}
