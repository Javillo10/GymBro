import 'package:flutter/material.dart';
import '../services/carga_rutinas.dart';
import 'rutina.dart';
import 'dart:math';

class ListaRutinas extends ChangeNotifier {
  List<Rutina> _misRutinas = [];

  List<Rutina> get misRutinas => _misRutinas;

  Rutina? rutinaAleatoria(){
    final random = Random();

    if (_misRutinas.isEmpty) return null;
    return _misRutinas[random.nextInt(_misRutinas.length)];
  }

  void cargarRutina(Rutina rutina) {
    rutina.addListener(() {
      guardar(); // 👈 se guarda todo cuando una rutina cambia
    });
  }

  Future<void> cargar() async {
    _misRutinas = await cargarRutinas();

    // 👇 IMPORTANTE: escuchar cada rutina
    for (final r in _misRutinas) {
      cargarRutina(r);
    }

    notifyListeners();
  }

  Future<void> anadir(Rutina rutina) async {
    _misRutinas.add(rutina);
    cargarRutina(rutina); // 👈 clave
    await guardar();
    notifyListeners();
  }

  Future<void> borrar(Rutina rutina) async {
    _misRutinas.remove(rutina);
    await guardar();
    notifyListeners();
  }

  Future<void> guardar() async {
    await guardarRutinas(_misRutinas);
  }

  Future<void> restaurar(Rutina rutina, int index) async {
    _misRutinas.insert(index, rutina);
    await guardar();
    notifyListeners();
  }
}
