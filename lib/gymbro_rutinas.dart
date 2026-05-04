import 'package:flutter/material.dart' hide AppBar;
import 'card_ancho.dart';
import 'gymbro_añadir_rutina.dart';
import 'gymbro_pantalla_rutina.dart';
import 'icono_barra.dart';
import 'appbar.dart';

// 👇 IMPORTANTE: importa modelo y servicio
import '../models/rutina.dart';
import '../services/carga_rutinas.dart';

class PantallaRutinas extends StatefulWidget {
  const PantallaRutinas({super.key});

  @override
  State<PantallaRutinas> createState() => _PantallaRutinaState();
}

class _PantallaRutinaState extends State<PantallaRutinas> {
  final RutinaService rutinaService = RutinaService();

  // 🔹 Lista de rutinas (ahora vacía)
  List<Rutina> misRutinas = [];

  @override
  void initState() {
    super.initState();
    _cargarRutinas();
  }

  // 🔹 Cargar desde JSON
  Future<void> _cargarRutinas() async {
    final rutinas = await rutinaService.cargarRutinas();

    setState(() {
      misRutinas = rutinas;
    });
  }


  // 🔹 Añadir rutina + guardar
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

      // 💾 Guardar en JSON
      await rutinaService.guardarRutinas(misRutinas);
    }
  }
  
  
  void _borrarRutina(Rutina rutina) async{
    setState(() {
      misRutinas.remove(rutina);
    });
    
    await rutinaService.guardarRutinas(misRutinas);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      body: Stack(
        children: [
          // 🔥 Glow de fondo
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
                  child: SingleChildScrollView(
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
                              IconoBarra(color: Colors.white, funcion: _navegarYAnadir, icono: Icons.add)
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // 📌 LISTA DINÁMICA
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: misRutinas.map((rutina) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PantallaDetalleRutina(rutina: rutina, funcionBorrar: _borrarRutina),
                                      ),
                                    );
                                  },
                                  child: CardAncho(
                                    Titulo: rutina.nombre,
                                    subTitulo: rutina.ejercicios,
                                    color: "1E2126",
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        // 🔹 Mensaje si no hay rutinas
                        if (misRutinas.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Center(
                              child: Text(
                                "No hay rutinas aún",
                                style: TextStyle(color: Colors.white54),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}