import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/rutina.dart';
import 'models/lista_rutinas.dart';

class PantallaEditarRutina extends StatefulWidget {
  final Rutina rutina;

  const PantallaEditarRutina({super.key, required this.rutina});

  @override
  State<PantallaEditarRutina> createState() => _PantallaEditarRutinaState();
}

class _PantallaEditarRutinaState extends State<PantallaEditarRutina> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.rutina.nombre);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color(0xFF1E2126),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF2D4E4A), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      appBar: AppBar(
        title: const Text("Editar Rutina"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration("Nombre de la rutina"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    widget.rutina.actualizarNombre(_controller.text);
                    Provider.of<ListaRutinas>(context, listen: false).guardar();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D4E4A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Guardar Cambios",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
