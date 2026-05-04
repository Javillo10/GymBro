import 'package:flutter/material.dart';

class CardAncho extends StatelessWidget{
  final String Titulo;
  final String subTitulo;
  final String color;

  const CardAncho({
    Key? key,
    required this.Titulo,
    required this.subTitulo,
    required this.color,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Color(int.parse("0xFF${this.color}")),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: 400, // 👈 ancho del card
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.Titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                this.subTitulo,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

}