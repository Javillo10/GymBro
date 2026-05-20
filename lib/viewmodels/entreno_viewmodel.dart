import 'package:flutter/foundation.dart';
import 'package:gymbro/models/entreno.dart';
import 'package:gymbro/models/rutina.dart';
import 'package:gymbro/services/entreno_service.dart';

class EntrenoViewModel extends ChangeNotifier {
  final EntrenoService _service;
  final Rutina _rutina;
  late List<bool> _ejerciciosCompletados;

  EntrenoViewModel(this._service, this._rutina) {
    _ejerciciosCompletados = List.filled(
      _rutina.getEjercicios.length,
      false,
    );
  }

  Rutina get rutina => _rutina;
  List<bool> get ejerciciosCompletados => _ejerciciosCompletados;
  int get completados => _ejerciciosCompletados.where((e) => e).length;
  int get total => _rutina.getEjercicios.length;

  void toggle(int index) {
    if (index >= 0 && index < _ejerciciosCompletados.length) {
      _ejerciciosCompletados[index] = !_ejerciciosCompletados[index];
      notifyListeners();
    }
  }

  Future<void> finalizar() async {
    final nombresCompletados = <String>[];
    for (int i = 0; i < _rutina.getEjercicios.length; i++) {
      if (_ejerciciosCompletados[i]) {
        nombresCompletados.add(_rutina.getEjercicios[i].nombre);
      }
    }

    final entreno = Entreno(
      nombreRutina: _rutina.nombre,
      fecha: DateTime.now(),
      ejerciciosCompletados: nombresCompletados,
      totalEjercicios: _rutina.getEjercicios.length,
    );

    await _service.anadir(entreno);
  }
}
