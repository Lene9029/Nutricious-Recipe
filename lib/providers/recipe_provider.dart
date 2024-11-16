import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../data_repository/dbHelper.dart';
import '../models/recipe_model.dart';

class RecipeClass extends ChangeNotifier {
  RecipeClass() {
    getRecipes();
  }

  bool isDark = false;
  changeIsDark() {
    isDark = !isDark;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController preperationTimeController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController allergensNameController = TextEditingController();
  TextEditingController restrictionsController = TextEditingController();
  TextEditingController allergenStatementController = TextEditingController();
  TextEditingController restrictionStatementController = TextEditingController();
  File? image;

  List<RecipeModel> allRecipes = [];
  List<RecipeModel> favoriteRecipes = [];
  List<RecipeModel> filteredRecipes = [];
  getRecipes() async {
    allRecipes = await DbHelper.dbHelper.getAllRecipes();
    favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
    notifyListeners();
  }

  //insertNewRecipe() {
    //RecipeModel recipeModel = RecipeModel(
        //name: nameController.text,
        //isFavorite: false,
        //imagePath: imagePath,
        //ingredients: ingredientsController.text,
        //instructions: instructionsController.text,
        //allergensName: allergensNameController.text,
        //restrictions: restrictionsController.text,
        //allergenStatement: allergenStatementController.text,
       // restrictionStatement: restrictionStatementController.text,
        //preperationTime: int.parse(preperationTimeController.text != ''
           // ? preperationTimeController.text
            //: '0'));
    //DbHelper.dbHelper.insertNewRecipe(recipeModel);
    //getRecipes();
  //}

  updateRecipe(RecipeModel recipeModel) async {
    await DbHelper.dbHelper.updateRecipe(recipeModel);
    getRecipes();
  }

  updateIsFavorite(RecipeModel recipeModel) {
    DbHelper.dbHelper.updateIsFavorite(recipeModel);
    getRecipes();
  }
  
  deleteRecipe(RecipeModel recipeModel) {
    DbHelper.dbHelper.deleteRecipe(recipeModel);
    getRecipes();
  }
   Future<void> filterAllRecipes(String value) async {
    allRecipes = await DbHelper.dbHelper.getAllRecipes();
    allRecipes = allRecipes.where((recipe) =>
      recipe.name.toLowerCase().contains(value.toLowerCase())
    ).toList();
    notifyListeners();
  }

  void filteredFavorites(String value) async {
 allRecipes = await DbHelper.dbHelper.getAllRecipes();
  favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
      favoriteRecipes = favoriteRecipes.where((recipe) =>
      recipe.name.toLowerCase().contains(value.toLowerCase())
    ).toList();
    notifyListeners();
  }

  
}
