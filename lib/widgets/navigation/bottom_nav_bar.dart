import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabSelected,
      items: items,
      type: BottomNavigationBarType.fixed, // Ensures all items are visible
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}