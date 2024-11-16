import 'package:flutter/material.dart';
import 'package:recipe_page_new/Detect_Object_Page.dart';
import 'package:recipe_page_new/profile_page.dart';
import 'package:recipe_page_new/ui/screens/all_recipe_screen.dart';
import 'package:recipe_page_new/ui/screens/favorite_recipes_screen.dart';
import 'package:recipe_page_new/Select_Ingredients_Page.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 2;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  final List<Widget> screens = [
    const MainRecipeScreen(),
    const SelectIngredientsPage(),
    const DetectObjectPage(),
    const FavoriteRecipesScreen(),
    ProfilePage(),
  ];
}
