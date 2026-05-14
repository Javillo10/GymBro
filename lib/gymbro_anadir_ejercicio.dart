import 'package:flutter/material.dart';
import '../models/ejercicio.dart';

class PantallaCrearEjercicio extends StatefulWidget {
  const PantallaCrearEjercicio({super.key});

  @override
  State<PantallaCrearEjercicio> createState() =>
      _PantallaCrearEjercicioState();
}

class _PantallaCrearEjercicioState extends State<PantallaCrearEjercicio> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController seriesController = TextEditingController();
  final TextEditingController grupoMuscular = TextEditingController();

  void _guardar() {
    final ejercicio = Ejercicio(
      nombre: nombreController.text,
      grupoMuscular: grupoMuscular.text,
      series: int.tryParse(seriesController.text) ?? 0,
    );

    Navigator.pop(context, ejercicio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),

      appBar: AppBar(
        title: const Text("Nuevo ejercicio"),
        backgroundColor: const Color(0xFF1E2126),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Nombre",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),

            TextField(
              controller: seriesController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Series",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),

            TextField(
              controller: grupoMuscular,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Grupo Muscular",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _guardar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D4E4A),
              ),
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}