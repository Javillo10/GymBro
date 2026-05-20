import 'package:flutter/foundation.dart';
import 'package:gymbro/models/rutina.dart';
import 'package:gymbro/services/rutina_service.dart';
import 'dart:math';

class ListaRutinasViewModel extends ChangeNotifier {
  final RutinaService _service;
  List<Rutina> _rutinas = [];

  ListaRutinasViewModel(this._service);

  List<Rutina> get rutinas => _rutinas;

  Rutina? rutinaAleatoria() {
    final random = Random();
    if (_rutinas.isEmpty) return null;
    return _rutinas[random.nextInt(_rutinas.length)];
  }

  Future<void> cargar() async {
    _rutinas = await _service.cargar();
    notifyListeners();
  }

  Future<void> anadir(Rutina rutina) async {
    _rutinas.add(rutina);
    await _service.guardar(_rutinas);
    notifyListeners();
  }

  Future<void> borrar(Rutina rutina) async {
    _rutinas.remove(rutina);
    await _service.guardar(_rutinas);
    notifyListeners();
  }

  Future<void> guardar() async {
    await _service.guardar(_rutinas);
  }

  Future<void> restaurar(Rutina rutina, int index) async {
    _rutinas.insert(index, rutina);
    await _service.guardar(_rutinas);
    notifyListeners();
  }
}
