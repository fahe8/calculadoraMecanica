import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CalculationsController extends GetxController {
  //Hidraulica
  var diametro = RxDouble(0.0);
  var velocidad = RxDouble(0.0);
  var viscosidadCinematica = RxDouble(0.0);
  var rugosidad = RxDouble(0.0);
  var numeroReynolds = RxDouble(0.0);
  var factorFriccion = RxDouble(0.0);
  var longitud = RxDouble(0.0);
  var caudal = RxDouble(0.0);
  var coeficienteK = RxDouble(0.0);
  var perdidasLongitudTuberia = RxDouble(0.0);
  var perdidasAccesorios = RxDouble(0.0);

  void calcularVelocidad() {
    final caudalActual = caudal.value;
    final diametroActual = diametro.value;

    if (diametroActual == 0) {
      velocidad.value = 0.0;
      return;
    }

    final area = calcularArea(diametroActual);
    final velocidadCalculada = caudalActual / area;
    velocidad.value = redondear(velocidadCalculada);
  }

  void calcularNumeroReynolds() {
    final velocidadActual = velocidad.value;
    final diametroActual = diametro.value;
    final viscosidadCinematicaActual = viscosidadCinematica.value;

    if (velocidadActual == 0 ||
        diametroActual == 0 ||
        viscosidadCinematicaActual == 0) {
      numeroReynolds.value = 0.0;
      return;
    }

    final reynoldsCalculado = calcularReynolds(
        velocidadActual, diametroActual, viscosidadCinematicaActual);
    numeroReynolds.value = redondear(reynoldsCalculado);
  }

  void calcularFactorFriccion() {
    final rugosidadActual = rugosidad.value;
    final diametroActual = diametro.value;
    final reynoldsActual = numeroReynolds.value;

    if (rugosidadActual == 0 || diametroActual == 0 || reynoldsActual == 0) {
      factorFriccion.value = 0.0;
      return;
    }

    final factorFriccionCalculado =
        calcularFactorFriccionSimplificado(rugosidadActual, reynoldsActual, diametroActual);
    factorFriccion.value = redondear(factorFriccionCalculado);
  }

  void calcularPerdidasLongitudTuberia() {
    final factorFriccionActual = factorFriccion.value;
    final diametroActual = diametro.value;
    final longitudActual = longitud.value;
    final caudalActual = caudal.value;

    if (factorFriccionActual == 0 ||
        diametroActual == 0 ||
        longitudActual == 0 ||
        caudalActual == 0) {
      perdidasLongitudTuberia.value = 0.0;
      return;
    }

    final gravedad = 9.81;
    final perdidasLongitud = calcularPerdidasLongitud(factorFriccionActual,
        longitudActual, caudalActual, diametroActual, gravedad);
    perdidasLongitudTuberia.value = redondear(perdidasLongitud);
  }

  void calcularPerdidasAccesorios() {
    final coeficienteKActual = coeficienteK.value;
    final diametroActual = diametro.value;
    final caudalActual = caudal.value;

    if (diametroActual == null || coeficienteKActual == null || caudalActual == null) {
      perdidasAccesorios.value = 0.0;
      return;
    }

    final gravedad = 9.81;
    final perdidasDeAccesorios = calcularPerdidasAccesorio(
        coeficienteKActual, caudalActual, diametroActual, gravedad);
    perdidasAccesorios.value = redondear(perdidasDeAccesorios);
  }

  // Funciones auxiliares

  double calcularArea(double diametro) {
    return pow(diametro / 2, 2) * pi;
  }

  double calcularReynolds(
      double velocidad, double diametro, double viscosidadCinematica) {
    return (velocidad * diametro) / viscosidadCinematica;
  }

 double calcularFactorFriccionSimplificado(double rugosidad, double reynolds, double diametro) {
  return 1.325 / pow(log((rugosidad / (3.7 * diametro)) + (5.74 / pow(reynolds, 0.9))), 2);
}


  double calcularPerdidasLongitud(double factorFriccion, double longitud,
      double caudal, double diametro, double gravedad) {
    return (8 * factorFriccion * longitud * (caudal * caudal)) /
        ((pi * pi) * gravedad * pow(diametro, 5));
  }

  double calcularPerdidasAccesorio(
      double coeficienteK, double caudal, double diametro, double gravedad) {
    return (8*coeficienteK*caudal*caudal)/(pi*pi*gravedad*pow(diametro, 4));
  }

  double redondear(double valor) {
    return double.parse(valor.toStringAsFixed(4));
  }
}

class CalculationsBombsController extends GetxController {}
