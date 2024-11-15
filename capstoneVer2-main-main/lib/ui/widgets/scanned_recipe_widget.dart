import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/Show_Scanned_Recipe.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';

class ScannedRecipeWidget extends StatefulWidget {
  const ScannedRecipeWidget(this.recipeModel, {super.key});

  final RecipeModel recipeModel;

  @override
  State<ScannedRecipeWidget> createState() => _ScannedRecipeWidgetState();
}

class _ScannedRecipeWidgetState extends State<ScannedRecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (context, recipeProvider, child) {
        // Fetch the updated RecipeModel to ensure synchronization.
        final updatedRecipe = recipeProvider.allRecipes.firstWhere(
          (recipe) => recipe.id == widget.recipeModel.id,
          orElse: () => widget.recipeModel,
        );

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ShowScannedRecipe(recipeModel: updatedRecipe),
              ),
            );
          },
          child: Card(
            color: Colors.transparent,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: updatedRecipe.imagePath == null ||
                          updatedRecipe.imagePath!.isEmpty
                      ? const Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/logo.png'),
                          ),
                        )
                      : Image.asset(
                          updatedRecipe.imagePath!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      recipeProvider.updateIsFavorite(updatedRecipe);
                    },
                    icon: updatedRecipe.isFavorite
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border, color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(1.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            updatedRecipe.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
