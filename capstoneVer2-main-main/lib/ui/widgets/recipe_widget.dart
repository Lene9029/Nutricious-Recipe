import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/ui/screens/show_recipe_screen.dart';

class RecipeWidget extends StatefulWidget {
  const RecipeWidget(this.recipeModel, {super.key});

  final RecipeModel recipeModel;

  @override
  State<RecipeWidget> createState() => _NewRecipeWidgetState();
}
  
class _NewRecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ShowRecipeScreen(recipeModel: widget.recipeModel),
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: widget.recipeModel.imagePath == null ||
                      !widget.recipeModel.imagePath!.isNotEmpty
                  ? const Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                            'images/logo.png'), 
                      ),
                    )
                  : Image.asset(
                      widget.recipeModel.imagePath!,
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
                  Provider.of<RecipeClass>(context, listen: false)
                      .updateIsFavorite(widget.recipeModel);
                },
                icon: widget.recipeModel.isFavorite
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
                        widget.recipeModel.name,
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
  }
}
