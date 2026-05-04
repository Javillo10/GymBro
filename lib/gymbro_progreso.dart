import 'package:flutter/material.dart' hide AppBar;
import 'appbar.dart';

class PantallaProgreso extends StatefulWidget {
  const PantallaProgreso({super.key});

  @override
  State<PantallaProgreso> createState() => _PantallaProgresoState();
}

class _PantallaProgresoState extends State<PantallaProgreso> {

  // 🔹 Variables de estado
  int contador = 0;

  // 🔹 Se ejecuta al iniciar la pantalla
  @override
  void initState() {
    super.initState();
    // lógica inicial
  }

  // 🔹 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      body: Stack(
        children: [
          // 🔥 Glow
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

          // 📱 Contenido
          SafeArea(
            child: Column(
              children: [
                // Header
                AppBar(),



                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        // 📌 CONTENEDOR DE RUTINAS
                        Container(
                          width: double.infinity, // 👈 ESTO ES LO QUE FALTA: Obliga a la columna a ser ancha
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Ahora sí funcionará
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "Progreso",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 11),
                            ],
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