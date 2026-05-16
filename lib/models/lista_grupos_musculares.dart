import 'package:flutter/material.dart';
import 'grupo_muscular.dart';

class ListaGruposMusculares {
  static final ListaGruposMusculares _instance =
      ListaGruposMusculares._internal();
  factory ListaGruposMusculares() => _instance;
  ListaGruposMusculares._internal();

  final List<GrupoMuscular> grupos = [
    GrupoMuscular(nombre: 'Pecho'),
    GrupoMuscular(nombre: 'Espalda'),
    GrupoMuscular(nombre: 'Piernas'),
    GrupoMuscular(nombre: 'Hombros'),
    GrupoMuscular(nombre: 'Bíceps'),
    GrupoMuscular(nombre: 'Tríceps'),
    GrupoMuscular(nombre: 'Core'),
    GrupoMuscular(nombre: 'Cardio'),
  ];

  GrupoMuscular getPorNombre(String nombre) {
    return grupos.firstWhere(
      (g) => g.nombre == nombre,
      orElse: () => GrupoMuscular(nombre: nombre),
    );
  }
}
