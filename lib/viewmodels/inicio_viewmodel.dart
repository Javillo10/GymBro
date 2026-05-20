import 'package:flutter/foundation.dart';
import 'package:gymbro/services/entreno_service.dart';

class InicioViewModel extends ChangeNotifier {
  final EntrenoService _service;
  int _entrenosSemana = 0;
  int _ejerciciosCompletadosSemana = 0;

  InicioViewModel(this._service);

  int get entrenosSemana => _entrenosSemana;
  int get ejerciciosCompletadosSemana => _ejerciciosCompletadosSemana;

  Future<void> cargar() async {
    final entrenos = await _service.cargar();

    final now = DateTime.now();
    final inicioSemana = now.subtract(Duration(days: now.weekday - 1));

    int entrenosSemana = 0;
    int ejerciciosSemana = 0;

    for (final entreno in entrenos) {
      if (entreno.fecha.isAfter(inicioSemana)) {
        entrenosSemana++;
        ejerciciosSemana += entreno.ejerciciosCompletados.length;
      }
    }

    _entrenosSemana = entrenosSemana;
    _ejerciciosCompletadosSemana = ejerciciosSemana;
    notifyListeners();
  }
}
