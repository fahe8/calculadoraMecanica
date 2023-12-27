import 'package:calculator/controllers/CalculationsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerUtils {
  static void initializeAndListenController({
  required TextEditingController controller,
  required RxDouble controllerValue,
  required CalculationsController calculationsController,
}) {
  controller.text = controllerValue.value == 0.0
      ? ''
      : controllerValue.value.toString();

  controller.addListener(() {
    controllerValue.value = double.tryParse(controller.text) ?? 0.0;
  });
}

}

