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

class TipoCurva {
  static const String CURVA = 'CURVA';
  static const String BOMBA = 'BOMBA';
  static const String VARIADOR = 'VARIADOR';
  static const String SERIE = 'SERIE';
  static const String PARALELO = 'PARALELO';
  static const String RODETE = 'RODETE';
  static const String NUEVACURVA = 'NUEVACURVA';
}

class BombaController extends GetxController {
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
  BombaModel bombaEliminada = bombas[index];
  bombas.removeAt(index);
  
  // Eliminar los puntos de la bomba eliminada
  puntosBomba.removeWhere((punto) => punto['bomba_id'] == bombaEliminada.id.toDouble());

  //Volver a generar los puntos de todas las bombas restantes
  generarPuntosBombas();

  generarGrafico();
}


  double calcularHR(double A, double B, double C, double caudal_metroCubico,
      int n, double alfa, double K, String tipo, String aumentarDisminuir, double lambda) {
    switch (tipo) {
      case TipoCurva.CURVA:
        return A + B * caudal_metroCubico * caudal_metroCubico;

      case TipoCurva.BOMBA:
        return (B != 0)
            ? A + B * caudal_metroCubico
            : A + C * caudal_metroCubico * caudal_metroCubico;

      case TipoCurva.VARIADOR:
        return (B != 0)
            ? A + B * caudal_metroCubico
            : A * (alfa * alfa) + (C * caudal_metroCubico * caudal_metroCubico);
      case TipoCurva.SERIE:
        return (n * A) +
            (n * B * caudal_metroCubico) +
            (n * C * caudal_metroCubico * caudal_metroCubico);
      case TipoCurva.PARALELO:
        return A +
            (B * caudal_metroCubico / n) +
            (C * pow(caudal_metroCubico, 2) / pow(n, 2));
      case TipoCurva.RODETE:
        return A* pow(lambda, 2) + B*caudal_metroCubico + (C*pow(caudal_metroCubico, 2))/pow(lambda, 2);
      case TipoCurva.NUEVACURVA:
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
      String aumentarDisminuir,
      double lambda) {
    double intervalo = 6;
    double caudal_litros = curvaResistente.value.Q;
    for (double q = 0; q <= caudal_litros + intervalo; q += intervalo) {
      double caudal_metroCubico = q / 1000;

      double hr = calcularHR(
          A, B, C, caudal_metroCubico, n, alfa, K, tipo, aumentarDisminuir, lambda);

      tipo != TipoCurva.BOMBA
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

    generarPuntos(puntosCurva, A, B, 0, 0, TipoCurva.CURVA, 0, 0, 0, '',0);
  }

  void generarGrafico() {
    puntosCurva.clear();
    generarPuntosCurva();
    showGraph.value = true;
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
    generarPuntos(puntosBomba, A, B, C, 0, TipoCurva.BOMBA, bomba.id, 0, 0, '',0);
  }

  List<FlSpot> obtenerPuntosDeBomba(int index) {
    List<FlSpot> spotsBomba = puntosBomba
        .where((punto) => punto['bomba_id'] == bombas[index].id.toDouble())
        .map((punto) => FlSpot(punto['caudal_litros']!, punto['h']!))
        .toList();

    return spotsBomba;
  }

  
  Map<String, dynamic> formulasHallar(
      int index, String tipo, String aumentarDisminuir) {
    BombaModel bomba = bombas[index];
    double A = bomba.A;
    double B = bomba.B;
    double C = bomba.C;

    double curvaA = curvaResistente.value.A;
    double curvaB = curvaResistente.value.B;
    double caudal_metroCubico = curvaResistente.value.Q / 1000.0;

    double hr = curvaA + curvaB * caudal_metroCubico * caudal_metroCubico;
    List<Map<String, double>> puntosGrafico = <Map<String, double>>[];

    switch (tipo) {
      case TipoCurva.VARIADOR:
        puntosGrafico = <Map<String, double>>[];
        double alfa;
        double inicio =
            (hr - (C * caudal_metroCubico * caudal_metroCubico)) / A;
        alfa = sqrt(inicio);

        generarPuntos(
            puntosGrafico, A, B, C, alfa, TipoCurva.VARIADOR, 0, 0, 0, '',0);
        Map<String, dynamic> result = {
          'puntos': puntosGrafico,
          'resultado': redondear(alfa),
        };
        return result;
      case TipoCurva.SERIE:
        puntosGrafico = <Map<String, double>>[];
        double resolverIzq = A +
            (B * caudal_metroCubico) +
            (C * caudal_metroCubico * caudal_metroCubico);
        double n = hr / resolverIzq;

        generarPuntos(
            puntosGrafico, A, B, C, 0, TipoCurva.SERIE, 0, n.round(), 0, '',0);

        Map<String, dynamic> result = {
          'puntos': puntosGrafico,
          'resultado': redondear(n),
        };
        return result;
      case TipoCurva.PARALELO:
        puntosGrafico = <Map<String, double>>[];
        double n;
        double nuevoQ;
        double nuevoB = B * caudal_metroCubico;
        double nuevoC = C * caudal_metroCubico * caudal_metroCubico;
        double nuevoA = (hr - A);

        if (nuevoB != 0) {
          double cuadraticaResuelta = cuadratica(A, nuevoB, nuevoC);
          n = cuadraticaResuelta;
        }
        n = sqrt(nuevoC / nuevoA);
        nuevoQ = 0;

        Map<String, dynamic> result = {
          'puntos': puntosGrafico,
          'resultado': redondear(n),
        };
        return result;

      case TipoCurva.RODETE:
        puntosGrafico = <Map<String, double>>[];
        double nuevoB = -(hr - B * caudal_metroCubico);
        double nuevoC = C * caudal_metroCubico * caudal_metroCubico;
        double nuevoA = A;

        double cuadraticaResuelta = cuadratica(nuevoA, nuevoB, nuevoC);
        double lambda = sqrt(cuadraticaResuelta);
        double porcentaje = 100 - (lambda * 100);
        generarPuntos(
            puntosGrafico, A, B, C, 0, TipoCurva.RODETE, 0, 0, 0, '',lambda);
        Map<String, dynamic> result = {
          'puntos': puntosGrafico,
          'resultado': redondear(lambda),
          'porcentaje': redondear(porcentaje)
        };
        return result;
      case TipoCurva.NUEVACURVA:
        puntosGrafico = <Map<String, double>>[];
        double hb = A +
            (B * caudal_metroCubico) +
            (C * caudal_metroCubico * caudal_metroCubico);

        double K = (hb - hr) / (caudal_metroCubico * caudal_metroCubico);

        generarPuntos(puntosGrafico, curvaA, curvaB, 0, 0, TipoCurva.NUEVACURVA,
            0, 0, K, aumentarDisminuir,0);
        Map<String, dynamic> result = {
          'puntos': puntosGrafico,
          'resultado': redondear(K),
        };
        return result;

      default:
        Map<String, dynamic> result = {};
        return result; // o cualquier valor predeterminado según tus necesidades
    }
  }

  

  Map<String, dynamic> bombaParalelo(int index) {
    BombaModel bomba = bombas[index];
    double A = bomba.A;
    double B = bomba.B;
    double C = bomba.C;

    double curvaA = curvaResistente.value.A;
    double curvaB = curvaResistente.value.B;
    double caudal_metroCubico = curvaResistente.value.Q / 1000.0;

    double hr = curvaA + curvaB * caudal_metroCubico * caudal_metroCubico;

    List<Map<String, double>> puntosGrafico = <Map<String, double>>[];

    double nuevoB = B * caudal_metroCubico;
    double nuevoC = C * caudal_metroCubico * caudal_metroCubico;
    double nuevoA = (hr - A);

    if (nuevoB != 0) {
      double cuadraticaResuelta = cuadratica(A, nuevoB, nuevoC);
    }
    int nuevoN = 2;
    print('A = $nuevoA' + ' B = $nuevoB ' + 'C = $nuevoC');
    double n = sqrt(nuevoC / nuevoA);
    double nuevoQ = sqrt(-A * nuevoN * nuevoN / C);
    print('valor N $n');
    print('valor nuevoQ $nuevoQ');


    Map<String, dynamic> result = {
      'puntos': puntosGrafico,
      'resultado': redondear(0),
      'porcentaje': redondear(0)
    };

    return result;
  }

  double cuadratica(double a, double b, double c) {
    // Calcular el discriminante
    double discriminant = b * b - 4 * a * c;

    if (discriminant < 0) {
      print("La ecuación cuadrática no tiene soluciones reales.");
      return double.nan; // Devolver NaN en caso de no haber soluciones reales
    } else if (discriminant == 0) {
      // Una solución real
      double root = -b / (2 * a);
      print("La solución única es: $root");
      return root;
    } else {
      // Dos soluciones reales
      double root1 = (-b + sqrt(discriminant)) / (2 * a);
      double root2 = (-b - sqrt(discriminant)) / (2 * a);
      print("Las soluciones son: $root1 y $root2");
      // Retornar una lista con las dos soluciones
      return root1;
    }
  }

  double redondear(double valor) {
    return double.parse(valor.toStringAsFixed(4));
  }
}
