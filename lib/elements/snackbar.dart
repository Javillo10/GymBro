import 'package:flutter/material.dart';

void buildSnackBar(
    BuildContext context,
    String texto,
    Color color,
    IconData icono, {
      String? actionLabel,
      VoidCallback? onAction,
    }) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icono, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),

      backgroundColor: const Color(0xFF1E2126),

      behavior: SnackBarBehavior.floating,

      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 90,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      elevation: 10,

      duration: const Duration(seconds: 3),


      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(
        label: actionLabel,
        textColor: color,
        onPressed: onAction,
      )
          : null,
    ),
  );
}