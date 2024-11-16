import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/providers/navigation_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
          return CurvedNavigationBar(
            height: 50,
            items: const <Widget>[
              Icon(Icons.restaurant_menu, size: 30),
              Icon(Icons.check_box_rounded, size: 30),
              Icon(Icons.camera, size: 30),
              Icon(Icons.favorite, size: 30),
              Icon(Icons.person, size: 30),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.lightGreen,
            backgroundColor: Colors.grey[200]!,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 500),
            onTap: (index) => navigationProvider.selectedIndex = index,
            index: navigationProvider.selectedIndex,
          );
        },
      ),
      body: Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
          return navigationProvider.screens[navigationProvider.selectedIndex];
        },
      ),
    );
  }
}
