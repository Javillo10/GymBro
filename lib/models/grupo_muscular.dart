import 'package:flutter/material.dart';

class GrupoMuscular {
  final String nombre;
  IconData icono;

  GrupoMuscular({required this.nombre}) : icono = Icons.help_center_outlined {
    if (nombre == "Pecho") {
      icono = Icons.sports_gymnastics_outlined;
    } else if (nombre == "Espalda") {
      icono = Icons.sports_handball;
    }
  }

  Map<String, dynamic> toJson() => {"nombre": nombre};

  factory GrupoMuscular.fromJson(Map<String, dynamic> json) {
    return GrupoMuscular(nombre: json["nombre"]);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrupoMuscular &&
          runtimeType == other.runtimeType &&
          nombre == other.nombre;

  @override
  int get hashCode => nombre.hashCode;
}
