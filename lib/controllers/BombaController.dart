import 'package:get/get.dart';

class BombaModel {
  static int _lastId = 0;

  int id;
  double A;
  double B;

  BombaModel({required this.A, required this.B, int? id}) : id = id ?? ++_lastId;
}


class CurvaModel {
  double A;
  double B;
  double Q;

  CurvaModel({required this.A, required this.B, required this.Q});
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
    double caudal_litros = curvaResistente.value.Q;
    double intervalo = 6;

    for (double q = 0; q <= caudal_litros + intervalo; q += intervalo) {
      double caudal_metroCubico = q / 1000.0;
      double hr = A - B * caudal_metroCubico * caudal_metroCubico;
      puntosBomba.add({
        'caudal_litros': q,
        'caudal_cubico': caudal_metroCubico,
        'HR': hr,
        'bomba_id': bomba.id.toDouble(), // Se añade el identificador único de la bomba
      });
    }
  }
}



// double A = 110;
      // double B = 48705.588;
      // double intervalo = 6;
      // double caudal_litros = 30.0;