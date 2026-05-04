class Rutina {
  final String nombre;
  final String ejercicios;

  Rutina({required this.nombre, required this.ejercicios});

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "ejercicios": ejercicios,
  };

  factory Rutina.fromJson(Map<String, dynamic> json) {
    return Rutina(
      nombre: json["nombre"],
      ejercicios: json["ejercicios"],
    );
  }
}