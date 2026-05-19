import 'package:flutter/material.dart';

class EfectoLuz extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
              ).withOpacity(0.5),
              const Color(0xFF121417).withOpacity(0.0),
            ],
          ),
        ),
      ),
    );
  }
}