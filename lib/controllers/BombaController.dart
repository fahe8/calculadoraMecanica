import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class BombaModel {
  static int _lastId = 0;

  int id;
  double A;
  double B;
  double C;

  BombaModel({this.A = 0, this.B = 0, this.C = 0, int? id})
      : id = id ?? ++_lastId;
}

class CurvaModel {
  double A;
  double B;
  double Q;

  CurvaModel({required this.A, required this.B, required this.Q});
}

class BombaController extends GetxController {
  static const String CURVA = 'curva';
  static const String NUEVACURVA = 'nuevacurva';
  static const String BOMBA = 'bomba';
  static const String VARIADOR = 'variador';
  static const String SERIE = 'serie';

  var bombas = <BombaModel>[].obs;
  List<Map<String, double>> puntosBomba = <Map<String, double>>[].obs;

  var curvaResistente = CurvaModel(A: 0, B: 0, Q: 0).obs;
  List<Map<String, double>> puntosCurva = <Map<String, double>>[].obs;
  RxBool showGraph = false.obs;

  void crearCurva(double A, double B, double Q) {
    if (A != 0 || B != 0 || Q != 0) {
      curvaResistente.value = CurvaModel(A: A, B: B, Q: Q);
      generarGrafico();
    } else {
      print(
          'Todos los valores de A, B y Q son cero. No se realizará ninguna acción.');
    }
  }

  void editarCurva(CurvaModel curva) {
    curvaResistente.value = curva;
    generarGrafico();
  }

  double calcularHR(double A, double B, double C, double caudal_metroCubico,
      int n, double alfa, double K, String tipo, String aumentarDisminuir) {
    switch (tipo) {
      case CURVA:
        return A + B * caudal_metroCubico * caudal_metroCubico;

      case BOMBA:
        return (B != 0)
            ? A + B * caudal_metroCubico
            : A + C * caudal_metroCubico * caudal_metroCubico;

      case VARIADOR:
        return (B != 0)
            ? A + B * caudal_metroCubico
            : A * (alfa * alfa) + (C * caudal_metroCubico * caudal_metroCubico);
      case SERIE:
        return (n * A) +
            (n * B * caudal_metroCubico) +
            (n * C * caudal_metroCubico * caudal_metroCubico);
      case NUEVACURVA:
        print('entrando a nuevacurva');
        return (aumentarDisminuir == 'aumentar')
            ? A +
                (B * caudal_metroCubico * caudal_metroCubico) +
                (K * caudal_metroCubico * caudal_metroCubico)
            : A +
                (B * caudal_metroCubico * caudal_metroCubico) -
                (K * caudal_metroCubico * caudal_metroCubico);

      default:
        return 0; // o cualquier valor predeterminado según tus necesidades
    }
  }

  void generarPuntos(
      List<Map<String, double>> listaPuntos,
      double A,
      double B,
      double C,
      double alfa,
      String tipo,
      int id,
      int n,
      double K,
      String aumentarDisminuir) {
    double intervalo = 6;
    double caudal_litros = curvaResistente.value.Q;
    for (double q = 0; q <= caudal_litros + intervalo; q += intervalo) {
      double caudal_metroCubico = q / 1000;

      double hr = calcularHR(
          A, B, C, caudal_metroCubico, n, alfa, K, tipo, aumentarDisminuir);

      tipo != BOMBA
          ? listaPuntos.add({
              'caudal_litros': q,
              'caudal_cubico': caudal_metroCubico,
              'h': hr,
            })
          : listaPuntos.add({
              'caudal_litros': q,
              'caudal_cubico': caudal_metroCubico,
              'h': hr,
              'bomba_id': id.toDouble(),
            });
    }
  }

  void generarPuntosCurva() {
    double A = curvaResistente.value.A;
    double B = curvaResistente.value.B;
    double caudal_litros = curvaResistente.value.Q;

    generarPuntos(puntosCurva, A, B, 0, 0, CURVA, 0, 0, 0, '');
  }

  void generarGrafico() {
    puntosCurva.clear();
    generarPuntosCurva();
    showGraph.value = true;
  }

  void agregarBomba(BombaModel bomba) {
    bombas.add(bomba);
    generarPuntosBomba(bomba);
    generarGrafico();
  }

  void editarBomba(BombaModel nuevaBomba, int index) {
    bombas[index] = nuevaBomba;
    generarPuntosBomba(nuevaBomba);
    generarGrafico();
  }

  void eliminarBombas(int index) {
    bombas.removeAt(index);
    // Puedes volver a generar los puntos de todas las bombas aquí
    generarPuntosBombas();
    generarGrafico();
  }

  void generarPuntosBombas() {
    puntosBomba.clear();
    for (var bomba in bombas) {
      generarPuntosBomba(bomba);
    }
  }

  void generarPuntosBomba(BombaModel bomba) {
    double A = bomba.A;
    double B = bomba.B;
    double C = bomba.C;
    double caudal_litros = curvaResistente.value.Q;
    generarPuntos(puntosBomba, A, B, C, 0, BOMBA, bomba.id, 0, 0,'');
  }

  List<FlSpot> obtenerPuntosDeBomba(int index) {
    List<FlSpot> spotsBomba = puntosBomba
        .where((punto) => punto['bomba_id'] == bombas[index].id.toDouble())
        .map((punto) => FlSpot(punto['caudal_litros']!, punto['h']!))
        .toList();

    return spotsBomba;
  }

  Map<String, dynamic> variadorDeFrecuencia(int index) {
    BombaModel bomba = bombas[index];
    double A = bomba.A;
    double B = bomba.B;
    double C = bomba.C;
    double curvaA = curvaResistente.value.A;
    double curvaB = curvaResistente.value.B;
    double caudal_metroCubico = curvaResistente.value.Q / 1000.0;
    double hr = curvaA + curvaB * caudal_metroCubico * caudal_metroCubico;

    double alfa = 0.0;
    List<Map<String, double>> puntosGrafico = <Map<String, double>>[];

    if (B != 0) {
    } else {
      // Despejar alfa para el caso H = A * alfa^2 + C * Q^2
      double inicio = (hr - (C * caudal_metroCubico * caudal_metroCubico)) / A;
      alfa = sqrt(inicio);
      generarPuntos(puntosGrafico, A, B, C, alfa, VARIADOR, 0, 0, 0,'');
    }
    Map<String, dynamic> result = {
      'puntos': puntosGrafico,
      'resultado': redondear(alfa),
    };
    // Ahora puedes usar el valor de alfa según sea necesario.

    return result;
  }

  Map<String, dynamic> bombaSerie(int index) {
    BombaModel bomba = bombas[index];
    double A = bomba.A;
    double B = bomba.B;
    double C = bomba.C;

    double curvaA = curvaResistente.value.A;
    double curvaB = curvaResistente.value.B;
    double caudal_metroCubico = curvaResistente.value.Q / 1000.0;
    double hr = curvaA + curvaB * caudal_metroCubico * caudal_metroCubico;

    List<Map<String, double>> puntosGrafico = <Map<String, double>>[];
    double n = 0.0;

    if (B != 0) {
    } else {
      double resolverIzq = A +
          (B * caudal_metroCubico) +
          (C * caudal_metroCubico * caudal_metroCubico);
      n = hr / resolverIzq;
      generarPuntos(puntosGrafico, A, B, C, 0, SERIE, 0, n.round(), 0,'');
    }

    Map<String, dynamic> result = {
      'puntos': puntosGrafico,
      'resultado': redondear(n),
    };

    return result;
  }

  Map<String, dynamic> nuevaCurvaResistente(
      int index, String aumentarDisminuir) {
    BombaModel bomba = bombas[index];
    double A = bomba.A;
    double B = bomba.B;
    double C = bomba.C;

    double curvaA = curvaResistente.value.A;
    double curvaB = curvaResistente.value.B;
    double caudal_metroCubico = curvaResistente.value.Q / 1000.0;

    double hr = curvaA + curvaB * caudal_metroCubico * caudal_metroCubico;
    double hb = A +
        (B * caudal_metroCubico) +
        (C * caudal_metroCubico * caudal_metroCubico);

    double K = (hb - hr) / (caudal_metroCubico * caudal_metroCubico);
    List<Map<String, double>> puntosGrafico = <Map<String, double>>[];

    generarPuntos(puntosGrafico, curvaA, curvaB, 0, 0, NUEVACURVA, 0, 0, K,
        aumentarDisminuir);

    Map<String, dynamic> result = {
      'puntos': puntosGrafico,
      'resultado': redondear(K),
    };
    print(puntosGrafico);
    return result;
  }

  double redondear(double valor) {
    return double.parse(valor.toStringAsFixed(4));
  }
}
