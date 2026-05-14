import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/rutina.dart';
import 'models/lista_rutinas.dart';
import 'icono_barra.dart';
import 'gymbro_anadir_ejercicio.dart';
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
          elevation: 0,
          actions: [
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
                                  subTituloIzquierda: ejercicio.grupoMuscular,
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

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF2D4E4A),
          child: const Icon(Icons.add, color: Colors.white),

          onPressed: () async {
            final ejercicio = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PantallaCrearEjercicio()),
            );

            if (ejercicio != null) {
              rutina.anadirEjercicio(ejercicio);
              Provider.of<ListaRutinas>(context, listen: false).guardar();
            }
          },
        ),
      ),
    );
  }
}
