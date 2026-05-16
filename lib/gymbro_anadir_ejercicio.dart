import 'package:flutter/material.dart';
import '../models/ejercicio.dart';
import '../models/grupo_muscular.dart';
import '../models/lista_grupos_musculares.dart';

class PantallaCrearEjercicio extends StatefulWidget {
  const PantallaCrearEjercicio({super.key});

  @override
  State<PantallaCrearEjercicio> createState() => _PantallaCrearEjercicioState();
}

class _PantallaCrearEjercicioState extends State<PantallaCrearEjercicio> {
  final TextEditingController nombreController = TextEditingController();

  final TextEditingController seriesController = TextEditingController();

  final ListaGruposMusculares _listaGrupos = ListaGruposMusculares();

  GrupoMuscular? grupoSeleccionado;

  void _guardar() {
    if (grupoSeleccionado == null) return;

    final ejercicio = Ejercicio(
      nombre: nombreController.text,
      grupoMuscular: grupoSeleccionado!,
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
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nombreController,

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E2126),

                hintText: "Nombre",

                hintStyle: const TextStyle(color: Colors.white54),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: seriesController,

              keyboardType: TextInputType.number,

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E2126),

                hintText: "Series",

                hintStyle: const TextStyle(color: Colors.white54),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<GrupoMuscular>(
              value: grupoSeleccionado,

              dropdownColor: const Color(0xFF1E2126),

              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E2126),

                hintText: 'Grupo muscular',

                hintStyle: const TextStyle(color: Colors.white54),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),

              style: const TextStyle(color: Colors.white),

              items: _listaGrupos.grupos.map((grupo) {
                return DropdownMenuItem(
                  value: grupo,
                  child: Row(
                    children: [
                      Icon(grupo.icono, color: Colors.white70, size: 20),
                      const SizedBox(width: 8),
                      Text(grupo.nombre),
                    ],
                  ),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  grupoSeleccionado = value;
                });
              },
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: _guardar,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D4E4A),

                  padding: const EdgeInsets.symmetric(vertical: 16),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                child: const Text(
                  "Guardar",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
