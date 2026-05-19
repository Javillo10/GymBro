import 'package:flutter/material.dart' hide AppBar;
import 'package:gymbro/elements/efecto_luz.dart';
import 'package:provider/provider.dart';

import 'elements/card_ancho.dart';
import 'gymbro_anadir_rutina.dart';
import 'gymbro_pantalla_rutina.dart';
import 'elements/icono_barra.dart';
import 'elements/appbar.dart';
import 'elements/snackbar.dart';

import '../models/rutina.dart';
import '../models/lista_rutinas.dart';

class PantallaRutinas extends StatelessWidget {
  const PantallaRutinas({super.key});


 //------------------------------------------------ DUDA -------------------------------
  Future<void> _navegarYAnadir(BuildContext context) async {
    final lista = Provider.of<ListaRutinas>(context, listen: false);

    final String? nombreRecibido = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaAnadirRutina(),
      ),
    );

    if (nombreRecibido != null && nombreRecibido.isNotEmpty) {
      final nueva = Rutina(
        nombre: nombreRecibido,
      );

      await lista.anadir(nueva);

      buildSnackBar(
        context,
        'Rutina añadida correctamente',
        const Color(0xFF2D4E4A),
        Icons.check_circle_outline,
      );
    }
  }


  Future<void> _borrarRutina(BuildContext context, Rutina rutina) async {
    final lista = Provider.of<ListaRutinas>(context, listen: false);

    final index = lista.misRutinas.indexOf(rutina);

    await lista.borrar(rutina);

    buildSnackBar(
      context,
      'Rutina eliminada',
      const Color(0xFF2D4E4A),
      Icons.check_circle_outline,
      actionLabel: 'DESHACER',
      onAction: () {
        lista.restaurar(rutina, index);
      },
    );
  }


  //:::::::::::::::::::::::::::::::::::: BUILD DE LA PAGINA ::::::::::::::::::::::::::::::::::::::::::.
  @override
  Widget build(BuildContext context) {
    final listaRutinas = Provider.of<ListaRutinas>(context);  //variable con las rutinas

    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      body: Stack(
        children: [
         EfectoLuz(),   //Creamos el efecto de luz de la interfaz

          SafeArea(
            child: Column(
              children: [
                AppBar(),   //Creamos la appbar personalizada

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      Padding(            // ↓ Configuración del título de la página con el botón de añadir rutina
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Rutinas",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconoBarra(color: Colors.white, funcion: () => _navegarYAnadir(context), icono: Icons.add,),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      Expanded(
                        child: listaRutinas.misRutinas.isEmpty ?

                        const Center(    // ↓ Si no hay rutinas muestra este texto ↓
                          child: Text(
                            "No hay rutinas aún",
                            style:
                            TextStyle(color: Colors.white54),
                          ),
                        )

                        :

                        ListView.builder(   // ↓ Si hay rutinas muestra una lista ↓
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: listaRutinas.misRutinas.length,    //Indica la cantidad de elementos que va a tener la lista
                          itemBuilder: (context, index) {     // ↓ Manera en la que se crea cada fila ↓
                            final rutinaActual = listaRutinas.misRutinas[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),

                              child: Dismissible(   // ↓ Configuración para deslizar y eliminar
                                key: Key('${rutinaActual.nombre}_$index'),    //Asignamos una clave única a cada dismissible
                                direction: DismissDirection.startToEnd,
                                onDismissed: (_) {
                                  _borrarRutina(context, rutinaActual);
                                },
                                background: Container(    // ↓ Configuramos como queremos el fondo y el estílo de la barra que aparece cuando delizamos
                                  padding: const EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),

                                child: GestureDetector(   // ↓ Usado para detectar los taps a la rutina y entrar en la rutina ↓
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaDetalleRutina(
                                              rutina: rutinaActual,
                                              funcionBorrar: (r) => _borrarRutina(context, r),
                                            ),
                                      ),
                                    );
                                  },
                                  child: CardAncho(   // ↓ Creamos la card ↓
                                    titulo: rutinaActual.nombre,
                                    subTituloIzquierda: rutinaActual.totalEjercicios,
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