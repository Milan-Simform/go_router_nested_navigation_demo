import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'A'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'X'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(index,
              initialLocation: index == navigationShell.currentIndex);
        },
      ),
    );
  }
}
