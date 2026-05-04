import 'package:flutter/material.dart';
import 'package:gymbro/gymbro_control_pantallas.dart';
import 'package:gymbro/gymbro_inicio.dart';

class GymbroAppApp extends StatelessWidget {
  const GymbroAppApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymBro',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFF3B3B),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Color(0xFF0D0D0D),
        cardColor: Color(0xFF1A1A1A),
      ),

      home: const HomeScreen(),
    );
  }
}