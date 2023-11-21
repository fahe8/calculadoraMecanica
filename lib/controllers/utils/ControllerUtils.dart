import 'package:calculator/controllers/CalculationsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerUtils {
  static void initializeAndListenController({
    required TextEditingController controller,
    required RxDouble controllerValue,
    required CalculationsController calculationsController,
  }) {
    if (controllerValue.value == 0.0) {
      controller.text = '';
    } else {
      controller.text = controllerValue.value.toString();
    }

    controller.addListener(() {
      controllerValue.value = double.tryParse(controller.text) ?? 0.0;
    });
  }
}
