import 'package:flutter/material.dart' hide AppBar;
import 'card_ancho.dart';
import 'gymbro_añadir_rutina.dart';
import 'gymbro_pantalla_rutina.dart';
import 'icono_barra.dart';
import 'appbar.dart';

import '../models/rutina.dart';
import '../services/carga_rutinas.dart';

class PantallaRutinas extends StatefulWidget {
  const PantallaRutinas({super.key});

  @override
  State<PantallaRutinas> createState() => _PantallaRutinaState();
}

class _PantallaRutinaState extends State<PantallaRutinas> {
  final RutinaService rutinaService = RutinaService();

  List<Rutina> misRutinas = [];

  @override
  void initState() {
    super.initState();
    _cargarRutinas();
  }

  Future<void> _cargarRutinas() async {
    final rutinas = await rutinaService.cargarRutinas();

    setState(() {
      misRutinas = rutinas;
    });
  }

  void _navegarYAnadir() async {
    final String? nombreRecibido = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PantallaAnadirRutina()),
    );

    if (nombreRecibido != null && nombreRecibido.isNotEmpty) {
      final nueva = Rutina(
        nombre: nombreRecibido,
        ejercicios: "0 ejercicios",
      );

      setState(() {
        misRutinas.add(nueva);
      });

      await rutinaService.guardarRutinas(misRutinas);
    }
  }

  void _borrarRutina(Rutina rutina) async {
    setState(() {
      misRutinas.remove(rutina);
    });

    await rutinaService.guardarRutinas(misRutinas);
  }

  void _mostrarSnackBar(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF2D4E4A)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                texto,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),

        backgroundColor: const Color(0xFF1E2126),

        behavior: SnackBarBehavior.floating,

        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 90, // 👈 separación de navbar
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        elevation: 10,

        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      body: Stack(
        children: [
          Positioned(
            top: -150,
            left: -50,
            right: -50,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2D4E4A).withOpacity(0.5),
                    const Color(0xFF121417).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                AppBar(),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Rutinas",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconoBarra(
                              color: Colors.white,
                              funcion: _navegarYAnadir,
                              icono: Icons.add,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      Expanded(
                        child: misRutinas.isEmpty
                            ? const Center(
                          child: Text(
                            "No hay rutinas aún",
                            style: TextStyle(color: Colors.white54),
                          ),
                        )
                            : ListView.builder(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: misRutinas.length,
                          itemBuilder: (context, index) {
                            final rutina = misRutinas[index];

                            return Padding(
                              padding:
                              const EdgeInsets.only(bottom: 12),
                              child: Dismissible(
                                key: Key('${rutina.nombre}_$index'),
                                direction:
                                DismissDirection.startToEnd,

                                onDismissed: (direction) {
                                  _borrarRutina(rutina);

                                  _mostrarSnackBar(
                                      'Rutina eliminada correctamente');
                                },

                                background: Container(
                                  padding:
                                  const EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),

                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaDetalleRutina(
                                              rutina: rutina,
                                              funcionBorrar: _borrarRutina,
                                            ),
                                      ),
                                    );
                                  },
                                  child: CardAncho(
                                    Titulo: rutina.nombre,
                                    subTitulo: rutina.ejercicios,
                                    color: "1E2126",
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}