import 'package:flutter/material.dart';

class PantallaAnadirRutina extends StatelessWidget {
  PantallaAnadirRutina({super.key});

  final TextEditingController _controller = TextEditingController();

  InputDecoration _inputDecoration(String hint) {   // ↓ Configuración del campo de texto
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.white54,
      ),

      filled: true,
      fillColor: const Color(0xFF1E2126),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFF2D4E4A),
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),

      appBar: AppBar(
        title: const Text("Nueva Rutina"),
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

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: _inputDecoration(
                "Nombre de la rutina",
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    Navigator.pop(
                      context,
                      _controller.text,
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF2D4E4A),

                  foregroundColor: Colors.white,

                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                ),

                child: const Text(
                  "Guardar Rutina",
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