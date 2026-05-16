import 'package:flutter/material.dart' hide AppBar;
import 'package:provider/provider.dart';
import 'package:gymbro/caja_elementos.dart';
import 'models/lista_rutinas.dart';
import 'services/carga_entrenos.dart';
import 'card_ancho.dart';
import 'appbar.dart';

class GymbroInicio extends StatefulWidget {
  const GymbroInicio({super.key});

  @override
  State<GymbroInicio> createState() => _GymBroInicioState();
}

class _GymBroInicioState extends State<GymbroInicio> {
  int _entrenosSemana = 0;
  int _ejerciciosCompletadosSemana = 0;

  @override
  void initState() {
    super.initState();
    _cargarEntrenos();
  }

  Future<void> _cargarEntrenos() async {
    final entrenos = await cargarEntrenos();

    final now = DateTime.now();
    final inicioSemana = now.subtract(Duration(days: now.weekday - 1));

    int entrenosSemana = 0;
    int ejerciciosSemana = 0;

    for (final entreno in entrenos) {
      if (entreno.fecha.isAfter(inicioSemana)) {
        entrenosSemana++;
        ejerciciosSemana += entreno.ejerciciosCompletados.length;
      }
    }

    setState(() {
      _entrenosSemana = entrenosSemana;
      _ejerciciosCompletadosSemana = ejerciciosSemana;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      body: Stack(
        children: [
          _crearEfectoLuz(),

          // 2. CONTENIDO DE LA APP
          SafeArea(
            child: Column(
              children: [
                AppBar(),

                // 3. CUERPO DE LA APP (Tus cajas)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        //TEXTO
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
                              const SizedBox(height: 11),

                              _crearEntrenoDelDia(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // CARDS
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Wrap(
                            spacing: 22,
                            runSpacing: 16,
                            alignment: WrapAlignment.start,
                            children: [
                              const Text(
                                "Tus estadísticas semanales",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 11),

                              SizedBox(
                                width: 150,
                                child: InfoCard(
                                  title: "Entrenos",
                                  value: "$_entrenosSemana",
                                  unit: "",
                                  icon: Icons.fitness_center,
                                  accentColor: const Color(0xFF2D4E4A),
                                ),
                              ),

                              SizedBox(
                                width: 150,
                                child: InfoCard(
                                  title: "Ejercicios",
                                  value: "$_ejerciciosCompletadosSemana",
                                  unit: "",
                                  icon: Icons.check_circle_outline,
                                  accentColor: const Color(0xFF2D4E4A),
                                ),
                              ),
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

  Widget _crearEfectoLuz() {
    return Positioned(
      top: -150,
      left: -50,
      right: -50,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(
                0xFF2D4E4A,
              ).withOpacity(0.5), // Color turquesa de la luz
              const Color(0xFF121417).withOpacity(0.0), // Se funde con el fondo
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearEntrenoDelDia() {
    final lista = Provider.of<ListaRutinas>(context, listen: false);

    final rutina = lista.rutinaAleatoria();

    if (rutina == null) {
      return CardAncho(titulo: "No hay rutinas guardadas", color: "2D4E4A");
    } else {
      return CardAncho(
        titulo: rutina.nombre,
        subTituloIzquierda: rutina.totalEjercicios,
        color: "2D4E4A",
      );
    }
  }
}
