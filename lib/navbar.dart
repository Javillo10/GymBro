import 'package:flutter/material.dart';

// --- WIDGET PRINCIPAL DE LA BARRA DE NAVEGACIÓN ---
class BottomGlowNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<NavBarItem> items;

  const BottomGlowNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
  }) : super(key: key);

  @override
  _BottomGlowNavBarState createState() => _BottomGlowNavBarState();
}

class _BottomGlowNavBarState extends State<BottomGlowNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. EL EFECTO DE LUZ (GLOW) DETRÁS
          _buildGlowLayer(),

          // 2. EL CONTENIDO DE LA BARRA (ICONOS Y TEXTOS)
          SafeArea(
            child: Container(
              height: 70, // Altura total de la barra
              decoration: BoxDecoration(
                color: Color(0xFF121417), // Color oscuro de fondo
                borderRadius: BorderRadius.circular(16), // Bordes redondeados
              ),
              child: Stack(
                children: [
                  // Capa 1: Los iconos clicables
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5), // Espacio para el indicador
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: widget.items.asMap().entries.map((entry) {
                        int idx = entry.key;
                        NavBarItem item = entry.value;
                        bool isSelected = idx == widget.selectedIndex;

                        return InkWell(
                          onTap: () => widget.onItemSelected(idx),
                          splashColor: Colors.transparent, // Sin efecto de toque feo
                          highlightColor: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item.icon,
                                color: isSelected ? Colors.white : Color(0xFF5F6873),
                                size: 26,
                              ),
                              SizedBox(height: 5),
                              Text(
                                item.label,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white : Color(0xFF5F6873),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Capa 2: EL INDICADOR DE COLOR Y GLOW ABAJO
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildIndicatorGlowRow(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Capa de resplandor general que se extiende fuera de la barra
  Widget _buildGlowLayer() {
    return Positioned(
      bottom: -30, // Posiciona la luz abajo
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Color(0xFF2D4E4A).withOpacity(0.5), // Color de la luz
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  // Fila que contiene el indicador de color específico para el elemento seleccionado
  Widget _buildIndicatorGlowRow() {
    return Container(
      height: 4, // Grosor de la línea del indicador
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.asMap().entries.map((entry) {
          int idx = entry.key;
          bool isSelected = idx == widget.selectedIndex;

          // Contenedor que solo muestra color y glow si está seleccionado
          return Expanded(
            child: isSelected
                ? FractionallySizedBox(
              widthFactor: 0.6, // Ancho de la línea de color (relativo al elemento)
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2D4E4A), // Color de la línea (verde azulado brillante)
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                  boxShadow: [
                    // Sombra que simula el GLOW del indicador de color
                    BoxShadow(
                      color: Color(0xFF2D4E4A).withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, -2), // Glow hacia arriba
                    ),
                  ],
                ),
              ),
            )
                : SizedBox.shrink(), // Oculto si no está seleccionado
          );
        }).toList(),
      ),
    );
  }
}

// --- CLASE DE DATOS PARA LOS ELEMENTOS ---
class NavBarItem {
  final IconData icon;
  final String label;

  NavBarItem({required this.icon, required this.label});
}