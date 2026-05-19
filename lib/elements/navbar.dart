import 'package:flutter/material.dart';


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

          _buildGlowLayer(),


          SafeArea(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF121417),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: widget.items.asMap().entries.map((entry) {
                        int idx = entry.key;
                        NavBarItem item = entry.value;
                        bool isSelected = idx == widget.selectedIndex;

                        return InkWell(
                          onTap: () => widget.onItemSelected(idx),
                          splashColor: Colors.transparent,
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


  Widget _buildGlowLayer() {
    return Positioned(
      bottom: -30,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Color(0xFF2D4E4A).withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildIndicatorGlowRow() {
    return Container(
      height: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.asMap().entries.map((entry) {
          int idx = entry.key;
          bool isSelected = idx == widget.selectedIndex;


          return Expanded(
            child: isSelected
                ? FractionallySizedBox(
              widthFactor: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2D4E4A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                  boxShadow: [

                    BoxShadow(
                      color: Color(0xFF2D4E4A).withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
              ),
            )
                : SizedBox.shrink(),
          );
        }).toList(),
      ),
    );
  }
}


class NavBarItem {
  final IconData icon;
  final String label;

  NavBarItem({required this.icon, required this.label});
}