import 'package:flutter/material.dart';

class NeumorphicBox extends StatelessWidget {
  final Color color;
  final double size;
  final double borderRadius;

  const NeumorphicBox({
    super.key,
    this.color = const Color(0xFF2D4E4A),
    this.size = 120,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white10,
            offset: Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }
}