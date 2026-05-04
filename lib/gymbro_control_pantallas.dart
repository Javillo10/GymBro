import 'package:flutter/material.dart';
import 'gymbro_inicio.dart';
import 'gymbro_rutinas.dart';
import 'gymbro_progreso.dart';
import 'navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  final List<Widget> _pages = const [
    PantallaProgreso(),
    GymbroInicio(),
    PantallaRutinas(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomGlowNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          NavBarItem(icon: Icons.bar_chart, label: "Progreso"),
          NavBarItem(icon: Icons.home, label: "Home"),
          NavBarItem(icon: Icons.fitness_center, label: "Rutinas"),
        ],
      ),
    );
  }
}