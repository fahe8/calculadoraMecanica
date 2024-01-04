import 'package:get/get.dart';

class BombaModel {
  double A;
  double B;
  double Q;

  BombaModel({this.A = 0.0, this.B = 0.0, this.Q = 0.0});
}

class CurvaModel {
  double A;
  double B;
  double Q;

  CurvaModel({required this.A, required this.B, required this.Q});
}

class BombaController extends GetxController {
  var curvas = <BombaModel>[].obs;
  var curvaSeleccionada = BombaModel().obs;

  List<Map<String, double>> puntosCurva = <Map<String, double>>[].obs;
  var curvaResistente = CurvaModel(A: 0, B: 0, Q: 0).obs;
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

  void generarPuntosCurva() {
    double A = curvaResistente.value.A;
    double B = curvaResistente.value.B;
    double caudal_litros = curvaResistente.value.Q;
    double intervalo = 6;

    for (double q = 0; q <= caudal_litros + intervalo; q += intervalo) {
      double caudal_metroCubico = q / 1000.0;
      double hr = A + B * caudal_metroCubico * caudal_metroCubico;
      puntosCurva.add({
        'caudal_litros': q,
        'caudal_cubico': caudal_metroCubico,
        'HR': hr,
      });
    }
  }

  void generarGrafico() {
    puntosCurva.clear();
    generarPuntosCurva();
    print('--------------------------------------------------');
    for (var punto in puntosCurva) {
      print('caudal_litros: ${punto['caudal_litros']}, HR: ${punto['HR']}');
    }
    showGraph.value = true;
  }
}


// double A = 110;
      // double B = 48705.588;
      // double intervalo = 6;
      // double caudal_litros = 30.0;