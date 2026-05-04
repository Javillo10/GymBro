import 'package:flutter/material.dart';

class IconoBarra extends StatelessWidget{
  final Color color;
  final VoidCallback funcion;
  final IconData icono;

  const IconoBarra({
    Key? key,
    required this.color,
    required this.funcion,
    required this.icono,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.funcion,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: this.color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(this.icono, color: this.color),
      ),
    );

  }

}