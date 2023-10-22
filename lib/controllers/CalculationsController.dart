import 'package:get/get.dart';
import 'package:scidart/scidart.dart';
import 'package:scidart/numdart.dart';

class CalculationsController extends GetxController {
  // Valores compartidos entre pantallas
  var diametro = RxDouble(0.0);
  var velocidad = RxDouble(0.0);
  var viscosidadCinematica = RxDouble(0.0);
  var rugosidad = RxDouble(0.0);
  var numeroReynolds = RxDouble(0.0);
  var factorFriccion = RxDouble(0.0);
  var longitud = RxDouble(0.0);
  var caudal = RxDouble(0.0);

  // Métodos para realizar cálculos y actualizar valores
void calcularVelocidad() {
  final caudalActual = caudal.value;
  final diametroActual = diametro.value;
  final area = pow(diametroActual / 2, 2) * pi;
  final velocidadCalculada = caudalActual / area;
  velocidad.value = velocidadCalculada;
}

void calcularNumeroReynolds() {
  final velocidadActual = velocidad.value;
  final diametroActual = diametro.value;
  final densidadFluido = 1000.0; // Densidad del agua en kg/m³ (reemplaza con el valor correcto)
  final viscosidadCinematicaActual = viscosidadCinematica.value ; // Viscosidad cinemática del agua en m²/s (reemplaza con el valor correcto)
  final reynoldsCalculado = (densidadFluido * velocidadActual * diametroActual) / viscosidadCinematicaActual;
  numeroReynolds.value = reynoldsCalculado;
}

  // void calcularNumeroReynolds() {
  //   // Obtener los valores actuales de velocidad, diámetro y viscosidad cinemática
  //   final velocidadActual = velocidad.value;
  //   final diametroActual = diametro.value;
  //   final viscosidadCinematicaActual = viscosidadCinematica.value;

  //   // Calcular el número de Reynolds
  //   final densidadFluido =
  //       1.0; // Densidad del fluido (reemplaza con el valor correcto)
  //   final reynoldsCalculado =
  //       (densidadFluido * velocidadActual * diametroActual) /
  //           viscosidadCinematicaActual;

  //   // Actualizar el valor del número de Reynolds en el controlador
  //   numeroReynolds.value = reynoldsCalculado;
  // }

  void calcularFactorFriccion() {}

  void calcularPerdidasLongitudTuberia() {}

  void calcularPerdidasAccesorios() {}

  // Otros métodos según tus necesidades

  // Método para reutilizar valores del cálculo anterior
  void reutilizarValoresAnteriores(CalculationsController controladorAnterior) {
    diametro.value = controladorAnterior.diametro.value;
    velocidad.value = controladorAnterior.velocidad.value;
    // Actualizar otros valores según sea necesario
  }
}

