import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_page_new/Detect_Object_Page.dart';
import 'package:recipe_page_new/Select_Ingredients_Page.dart';
import 'package:recipe_page_new/profile_page.dart';
import 'package:recipe_page_new/ui/screens/all_recipe_screen.dart';
import 'package:recipe_page_new/ui/screens/favorite_recipes_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          height: 50,
          items: const <Widget>[
            Icon(Icons.restaurant_menu, size: 30),
            Icon(Icons.add, size: 30),
            Icon(Icons.camera, size: 30),
            Icon(Icons.favorite, size: 30),
            Icon(Icons.person, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.blue,
          backgroundColor: Colors.grey[200]!, 
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (index) => controller.selectedIndex.value = index,
          index: controller.selectedIndex.value,
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 2.obs; 

  final screens = [
    const MainRecipeScreen(),
    const SelecIgredientsPage(),
    const DetectObjectPage(),
    const FavoriteRecipesScreen(),
    ProfilePage()
  ];
}
