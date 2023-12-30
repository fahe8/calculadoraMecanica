import 'package:get/get.dart';

class BombaModel {
  double? A;
  double? B;
  double? C;
  double? Q;
  Map<String, double> resultados = {'suma': 0, 'resta': 0};

  BombaModel({this.A, this.B, this.C, this.Q}) {
    calcularResultados();
  }

  double sumarAB() {
    double result = (A ?? 0) + (B ?? 0);
    resultados['suma'] = result;
    return result;
  }

  double restarCQ() {
    double result = (C ?? 0) - (Q ?? 0);
    resultados['resta'] = result;
    return result;
  }

  void editarValores({double? nuevoA, double? nuevoB, double? nuevoC, double? nuevoQ}) {
    A = nuevoA ?? A;
    B = nuevoB ?? B;
    C = nuevoC ?? C;
    Q = nuevoQ ?? Q;
    calcularResultados();
  }

  void calcularResultados() {
    resultados['suma'] = sumarAB();
    resultados['resta'] = restarCQ();
  }
}


class BombaController extends GetxController {
  var curvas = <BombaModel>[].obs;
  var curvaSeleccionada = BombaModel().obs;

  void agregarCurva(BombaModel curva) {
    curvas.add(curva);
  }

  void seleccionarCurva(BombaModel curva) {
    curvaSeleccionada.value = curva;
  }

  void modificarValoresCurva(int index,double? nuevoA, double? nuevoB, double? nuevoC, double? nuevoQ) {
    curvas[index].editarValores( nuevoA: nuevoA,
        nuevoB: nuevoB,
        nuevoC: nuevoC,
        nuevoQ: nuevoQ,);
   
  }

  void eliminarCurva(int index) {
    
      curvas.removeAt(index);
  
  }
}
