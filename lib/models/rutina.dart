import 'package:flutter/cupertino.dart';
import 'ejercicio.dart';

class Rutina extends ChangeNotifier {
  final String nombre;
  List<Ejercicio> _ejercicios = [];

  Rutina({required this.nombre, List<Ejercicio>? ejercicios})
    : _ejercicios = ejercicios ?? [];

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,

      'ejercicios': _ejercicios.map((e) => e.toJson()).toList(),
    };
  }

  factory Rutina.fromJson(Map<String, dynamic> json) {
    return Rutina(
      nombre: json["nombre"],

      ejercicios: (json["ejercicios"] as List)
          .map((e) => Ejercicio.fromJson(e))
          .toList(),
    );
  }

  void anadirEjercicio(Ejercicio ejercicio) {
    _ejercicios.add(ejercicio);
    notifyListeners();
  }

  List<Ejercicio> get getEjercicios => _ejercicios;
  String get totalEjercicios => '${_ejercicios.length} ejercicios';
}
