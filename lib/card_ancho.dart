import 'package:flutter/material.dart';

class CardAncho extends StatelessWidget {
  final String titulo;
  final String? subTituloIzquierda;
  final String? numero;
  final String? subTituloDerecha;
  final String color;

  const CardAncho({
    super.key,
    required this.titulo,
    this.subTituloIzquierda,
    this.numero,
    this.subTituloDerecha,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Color(int.parse("0xFF$color")),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (subTituloIzquierda != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        subTituloIzquierda!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              if (numero != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      numero!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (subTituloDerecha != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subTituloDerecha!,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}