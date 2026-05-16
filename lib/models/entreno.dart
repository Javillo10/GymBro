class Entreno {
  final String nombreRutina;
  final DateTime fecha;
  final List<String> ejerciciosCompletados;
  final int totalEjercicios;

  Entreno({
    required this.nombreRutina,
    required this.fecha,
    required this.ejerciciosCompletados,
    required this.totalEjercicios,
  });

  Map<String, dynamic> toJson() => {
    "nombreRutina": nombreRutina,
    "fecha": fecha.toIso8601String(),
    "ejerciciosCompletados": ejerciciosCompletados,
    "totalEjercicios": totalEjercicios,
  };

  factory Entreno.fromJson(Map<String, dynamic> json) {
    return Entreno(
      nombreRutina: json["nombreRutina"],
      fecha: DateTime.parse(json["fecha"]),
      ejerciciosCompletados: List<String>.from(json["ejerciciosCompletados"]),
      totalEjercicios: json["totalEjercicios"],
    );
  }
}
