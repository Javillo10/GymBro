import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/rutina.dart';
import 'models/lista_rutinas.dart';
import 'icono_barra.dart';
import 'gymbro_anadir_ejercicio.dart';
import 'gymbro_editar_rutina.dart';
import 'gymbro_entreno.dart';
import 'card_ancho.dart';

class PantallaDetalleRutina extends StatelessWidget {
  final Rutina rutina;
  final void Function(Rutina) funcionBorrar;

  const PantallaDetalleRutina({
    super.key,
    required this.rutina,
    required this.funcionBorrar,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: rutina,
      child: Scaffold(
        backgroundColor: const Color(0xFF121417),

        appBar: AppBar(
          title: Consumer<Rutina>(
            builder: (context, rutina, _) {
              return Text(rutina.nombre);
            },
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaEditarRutina(rutina: rutina),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconoBarra(
                color: Colors.red,
                icono: Icons.delete_outline,
                funcion: () {
                  funcionBorrar(rutina);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),

        body: Consumer<Rutina>(
          builder: (context, rutina, _) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: rutina.getEjercicios.isEmpty
                        ? const Center(
                            child: Text(
                              "No hay ejercicios aún",
                              style: TextStyle(color: Colors.white54),
                            ),
                          )
                        : ListView.builder(
                            itemCount: rutina.getEjercicios.length,
                            itemBuilder: (context, index) {
                              final ejercicio = rutina.getEjercicios[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: CardAncho(
                                  titulo: ejercicio.nombre,
                                  subTituloIzquierda:
                                      ejercicio.grupoMuscular.nombre,
                                  iconoIzquierda: ejercicio.grupoMuscular.icono,
                                  numero: "${ejercicio.series}",
                                  subTituloDerecha: "series",
                                  color: "1E2126",
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),

        floatingActionButton: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: PopupMenuButton<String>(
            color: const Color(0xFF2D4E4A),
            offset: const Offset(0, -120),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFF2D4E4A),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.menu, color: Colors.white),
            ),
            onSelected: (value) async {
              if (value == 'start') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaEntreno(rutina: rutina),
                  ),
                );
              } else if (value == 'add') {
                final ejercicio = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaCrearEjercicio(),
                  ),
                );

                if (ejercicio != null) {
                  rutina.anadirEjercicio(ejercicio);
                  Provider.of<ListaRutinas>(context, listen: false).guardar();
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'start',
                height: 48,
                child: const Row(
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Iniciar entrenamiento',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'add',
                height: 48,
                child: const Row(
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Añadir ejercicio',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
