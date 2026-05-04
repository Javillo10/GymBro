import 'package:flutter/material.dart';
import 'gymbro_rutinas.dart'; // Importa donde tengas el modelo 'Rutina'
import 'models/rutina.dart';
import 'icono_barra.dart';


class PantallaDetalleRutina extends StatefulWidget {
  final Rutina rutina;
  final void Function(Rutina) funcionBorrar;

  const PantallaDetalleRutina({super.key, required this.rutina, required this.funcionBorrar});

  @override
  State<PantallaDetalleRutina> createState() => _PantallaDetalleRutinaState();
}


class _PantallaDetalleRutinaState extends State<PantallaDetalleRutina> {
  late Rutina rutina;
  late void Function(Rutina) funcionBorrar;

  @override
  void initState(){
    super.initState();
    rutina = widget.rutina;
    funcionBorrar = widget.funcionBorrar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      appBar: AppBar(
        title: Text(rutina.nombre), // Muestra el nombre de la rutina clicada
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconoBarra(color: Colors.red, funcion: () { funcionBorrar(rutina); Navigator.pop(context); }, icono: Icons.delete_outline)
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 80, color: Color(0xFF2D4E4A)),
            const SizedBox(height: 20),
            Text(
              "Ejercicios para ${rutina.nombre}",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              rutina.ejercicios,
              style: const TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}