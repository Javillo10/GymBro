class Ejercicio {
  final String nombre;
  final String grupoMuscular;
  final int series;

  Ejercicio({required this.nombre, required this.grupoMuscular, required this.series});

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "grupoMuscular": grupoMuscular,
    "series": series,
  };

  factory Ejercicio.fromJson(Map<String, dynamic> json){
    return Ejercicio(
      nombre: json["nombre"],
      grupoMuscular: json["grupoMuscular"],
      series: json["series"],
    );
  }

}