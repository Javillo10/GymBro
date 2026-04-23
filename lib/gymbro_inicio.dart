import 'package:flutter/material.dart';
import 'package:gymbro/caja_elementos.dart';
import 'dart:ui';

class GymbroInicio extends StatefulWidget {
  const GymbroInicio({super.key});

  @override
  State<GymbroInicio> createState() => _GymBroInicioState();
}

class _GymBroInicioState extends State<GymbroInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417), // Fondo oscuro profundo
      body: Stack(
        children: [
          // 1. EL EFECTO DE LUZ (GLOW)
          // Usamos un Positioned para que la luz salga desde la esquina superior
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
                    const Color(0xFF2D4E4A).withOpacity(0.5), // Color turquesa de la luz
                    const Color(0xFF121417).withOpacity(0.0), // Se funde con el fondo
                  ],
                ),
              ),
            ),
          ),

          // 2. CONTENIDO DE LA APP
          SafeArea(
            child: Column(
              children: [
                // AppBar Personalizada (Manual para controlar mejor el diseño)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "GymBro",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "No Pain No Gain",
                            style: TextStyle(color: Colors.white54, fontSize: 14),
                          ),
                        ],
                      ),
                      _buildIconGrid(),
                    ],
                  ),
                ),

                // 3. CUERPO DE LA APP (Tus cajas)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 👈 IMPORTANTE
                      children: [
                        const SizedBox(height: 10),

                        // 📌 TEXTO
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "Tu entreno de hoy es...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const SizedBox(height: 5),


                              Card(
                                elevation: 8,
                                color: const Color(0xFF1A1A1A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: SizedBox(
                                  width: 400, // 👈 ancho del card
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Pierna / Glúteo',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '45 min · Intensidad media',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),


                        const SizedBox(height: 15),

                        // 📦 CARDS
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.start, // 👈 CLAVE
                            children: [
                              const BoxPlaceholder(color: Color(0xFF2D4E4A)),
                              const BoxPlaceholder(color: Color(0xFF2D4E4A)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconGrid() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.grid_view_rounded, color: Colors.white),
    );
  }
}

// Widget temporal para que no te de error si no tienes NeumorphicBox a mano
class BoxPlaceholder extends StatelessWidget {
  final Color color;
  const BoxPlaceholder({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}