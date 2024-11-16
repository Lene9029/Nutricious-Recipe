
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/providers/alleres_provider.dart';
import 'package:recipe_page_new/providers/navigation_provider.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/providers/result_Provider.dart';
import 'package:recipe_page_new/ui/screens/favorite_recipes_screen.dart';
import 'package:recipe_page_new/ui/screens/all_recipe_screen.dart';
import 'package:recipe_page_new/ui/screens/splash_screen.dart';

import 'data_repository/dbHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<RecipeClass>(
          create: (context) => RecipeClass(),),
          ChangeNotifierProvider<AlleresProvider>(
          create: (context) => AlleresProvider(),),
          ChangeNotifierProvider(create: (_) => ResultProvider()),
          ChangeNotifierProvider<NavigationProvider>(
          create: (context) => NavigationProvider())
          ],
        child: const InitApp());
    
  }
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<RecipeClass>(context).isDark
          ? ThemeData.dark()
          : ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.blue[200],
              dialogBackgroundColor: Colors.blue[200],
              primaryColor: Colors.blue[200]),
      title: 'nutrirecipe',
      home: const SplashScreen(),
      routes: {
        
        '/favorite_recipes_screen': (context) => const FavoriteRecipesScreen(),
        '/main_recipe_screen': (context) => const MainRecipeScreen(),
               
      },
    );
  }
}
