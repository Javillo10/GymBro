import 'package:flutter/material.dart' hide AppBar;
import 'package:provider/provider.dart';
import 'package:gymbro/elements/caja_elementos.dart';
import 'models/lista_rutinas.dart';
import 'services/carga_entrenos.dart';
import 'elements/card_ancho.dart';
import 'elements/appbar.dart';
import 'elements/efecto_luz.dart';

class GymbroInicio extends StatefulWidget {
  const GymbroInicio({super.key});

  @override
  State<GymbroInicio> createState() => _GymBroInicioState();
}

class _GymBroInicioState extends State<GymbroInicio> {
  int _entrenosSemana = 0;    //Variable para llevar el conteo de los entrenos de la semana
  int _ejerciciosCompletadosSemana = 0;   //Variable para llevar el conteio de los ejercicios completados en la semanda


  //:::::::::::::::::::::: INITSTATE() :::::::::::::::::
  @override
  void initState() {
    super.initState();
    _cargarEntrenos();
  }

 //------------------------------------------------ DUDA -------------------------------
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


  //:::::::::::::::::::::::::::::::::::: BUILD DE LA PAGINA ::::::::::::::::::::::::::::::::::::::::::.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      body: Stack(
        children: [
          EfectoLuz(),  //Constructor del widget del efecto de luz de arriba

          // 2. CONTENIDO DE LA APP
          SafeArea(
            child: Column(
              children: [
                AppBar(),   //Constructor de la appbar personalizada

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
                              const SizedBox(height: 10),    //Usado para la separación

                              const Text(                     //↓ Configuración del texto que mostrará el entreno del dia ↓
                                "Tu entreno de hoy es...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 11),

                              _crearEntrenoDelDia(),  //Constructor del cajón con el entreno del día
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),   //Usado para la separación

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              Wrap(
                                spacing: 22,
                                runSpacing: 16,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: InfoCard(title: "Entrenos", value: "$_entrenosSemana", unit: "", icon: Icons.fitness_center, accentColor: const Color(0xFF2D4E4A),),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: InfoCard(title: "Ejercicios", value: "$_ejerciciosCompletadosSemana", unit: "", icon: Icons.check_circle_outline, accentColor: const Color(0xFF2D4E4A),),
                                  ),
                                ],
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


//:::::::::::::::::::::::::::::::::::::::: CREACIÓN DEL WIDGET ENTRENO DEL DÍA ::::::::::::::::::::::::::::
  Widget _crearEntrenoDelDia() {
    final listaRutinas = Provider.of<ListaRutinas>(context, listen: false);

    final rutinaEscogida = listaRutinas.rutinaAleatoria();

    if (rutinaEscogida == null) {
      return CardAncho(titulo: "No hay rutinas guardadas", color: "2D4E4A");
    } else {
      return CardAncho(
        titulo: rutinaEscogida.nombre,
        subTituloIzquierda: rutinaEscogida.totalEjercicios,
        color: "2D4E4A",
      );
    }
  }
}
