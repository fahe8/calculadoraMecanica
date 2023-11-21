import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Bomba {
  final double valorA;
  final double valorB;
  final double caudal;
  final double? valorC;
  final Color? color;

  Bomba(
      {required this.valorA,
      required this.valorB,
      required this.caudal,
      this.valorC,
      this.color});

}

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
      // Evitar dividir por cero
      velocidad.value = 0.0;
      return;
    }

    // Convertir el caudal a metros cúbicos por segundo
    // final caudalActualMetrosCubicosPorSegundo =
    //     caudalActualLitrosPorSegundo / 1000.0;

    final area = pow(diametroActual / 2, 2) * pi;
    final velocidadCalculada = caudalActual / area;

    // Limitar el resultado a 4 decimales
    velocidad.value = double.parse(velocidadCalculada.toStringAsFixed(4));
  }

  void calcularNumeroReynolds() {
    final velocidadActual = velocidad.value;
    final diametroActual = diametro.value;
    final viscosidadCinematicaActual = viscosidadCinematica.value;

    if (velocidadActual == 0 ||
        diametroActual == 0 ||
        viscosidadCinematicaActual == 0) {
      // Evitar divisiones por cero
      numeroReynolds.value = 0.0;
      return;
    }

    final densidadFluido = 1000.0;
    final reynoldsCalculado =
        (densidadFluido * velocidadActual * diametroActual) /
            viscosidadCinematicaActual;
    numeroReynolds.value = double.parse(reynoldsCalculado.toStringAsFixed(4));
  }

  void calcularFactorFriccion() {
    final rugosidadActual = rugosidad.value;
    final diametroActual = diametro.value;
    final reynoldsActual = numeroReynolds.value;

    if (rugosidadActual == 0 || diametroActual == 0 || reynoldsActual == 0) {
      // Manejar valores nulos o faltantes
      factorFriccion.value = 0.0;
      return;
    }

    // Cálculo del factor de fricción usando la fórmula simplificada proporcionada
    final epsilonD = rugosidadActual / diametroActual;
    var factorFriccionCalculado = 0.0;

    // Flujo turbulento
    factorFriccionCalculado =
        0.25 / pow(log(epsilonD / 3.7 + 5.74 / pow(reynoldsActual, 0.9)), 2);

    factorFriccion.value =
        double.parse(factorFriccionCalculado.toStringAsFixed(4));
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
      // Manejar valores nulos o faltantes
      // Puedes establecer un valor predeterminado o mostrar un mensaje de error
      perdidasLongitudTuberia.value = 0.0;
      return;
    }
    final gravedad = 9.81;

    final perdidasLongitud = (8 *
            factorFriccionActual *
            longitudActual *
            (caudalActual * caudalActual)) /
        ((pi * pi) * gravedad * pow(diametroActual, 5));
    perdidasLongitudTuberia.value =
        double.parse(perdidasLongitud.toStringAsFixed(4));
  }

  void calcularPerdidasAccesorios() {
    final coeficienteKActual = coeficienteK.value;
    final velocidadActual = velocidad.value;

    if (velocidadActual == null || coeficienteKActual == null) {
      perdidasAccesorios.value = 0.0;
      return;
    }
    final gravedad = 9.81;
    final perdidasDeAccesorios =
        coeficienteKActual * (pow(velocidadActual, 2) / 2 * gravedad);
    perdidasAccesorios.value =
        double.parse(perdidasDeAccesorios.toStringAsFixed(4));
  }

  //Bombas
  RxList<Bomba> bombas = <Bomba>[].obs;


  void crearNuevaBomba(double valorA, double valorB, double caudal,
      {Color? color, double? valorC}) {
    if (valorA == 0.0 && valorB == 0.0 && caudal == 0.0) {
      return;
    }


    bombas.add(Bomba(
        valorA: valorA,
        valorB: valorB,
        valorC: valorC,
        caudal: caudal,
        color: color ??
            Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),
                Random().nextInt(256), 1.0)));
    update();
  }

  void eliminarBomba(int index) {
    if (index >= 0 && index < bombas.length) {
      bombas.removeAt(index);
      update();
    }
  }

  void actualizarBomba(
      int index, double nuevoValorA, double nuevoValorB, double nuevoCaudal,
      {double? nuevoValorC}) {
    if (index >= 0 && index < bombas.length) {
      bombas[index] = Bomba(
        valorA: nuevoValorA,
        valorB: nuevoValorB,
        caudal: nuevoCaudal,
        valorC: nuevoValorC, // Puedes pasar nuevoValorC o dejarlo como null
      );
      update();
    }
  }

  List<Bomba> obtenerBombas() {
    return bombas;
  }

  Bomba obtenerBomba(int index) {
    if (index >= 0 && index < bombas.length) {
      print(bombas[index]);
      return bombas[index];
      
    }
    throw Exception('Índice de bomba fuera de rango');
  }

  
  double calcularCurva(valorA, valorB, caudal) {
    return valorA + valorB * pow(caudal, 2);
  }
}
