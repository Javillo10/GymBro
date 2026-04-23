import 'package:flutter/material.dart';
import 'package:gymbro/gymbro_inicio.dart';

class ConversorApp extends StatelessWidget {
  const ConversorApp({super.key});
  @override
  Widget build(BuildContext context) {
// 2
    return MaterialApp(
      title: 'GymBro',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFF3B3B), // rojo intenso (acento)
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Color(0xFF0D0D0D), // fondo principal
        cardColor: Color(0xFF1A1A1A), // tarjetas
      ),
// 3
      home: const GymbroInicio(),
    );
  }
}