import 'grupo_muscular.dart';

class Ejercicio {
  final String nombre;
  final GrupoMuscular grupoMuscular;
  final int series;

  Ejercicio({
    required this.nombre,
    required this.grupoMuscular,
    required this.series,
  });

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "grupoMuscular": grupoMuscular.toJson(),
    "series": series,
  };

  factory Ejercicio.fromJson(Map<String, dynamic> json) {
    return Ejercicio(
      nombre: json["nombre"],
      grupoMuscular: GrupoMuscular.fromJson(json["grupoMuscular"]),
      series: json["series"],
    );
  }
}
