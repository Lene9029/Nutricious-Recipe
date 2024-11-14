import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/providers/result_Provider.dart';

class ShowScannedRecipe extends StatefulWidget {
  final RecipeModel recipeModel;

  const ShowScannedRecipe({super.key, required this.recipeModel});

  @override
  State<ShowScannedRecipe> createState() => _ShowScannedRecipeState();
}

class _ShowScannedRecipeState extends State<ShowScannedRecipe> {
  List<String> scannedIngredients = [];
  List<String> missingIngredients = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final resultProvider = Provider.of<ResultProvider>(context);
    setState(() {
      scannedIngredients = resultProvider.resultData;
    });
    missingRecipes();
  }

  void missingRecipes() {
    List<String> recipeIngredientsList = widget.recipeModel.ingredients
        .split('\r\n')
        .map((ingredient) => ingredient.toLowerCase())
        .toList();

    setState(() {
      missingIngredients = recipeIngredientsList
          .where((ingredient) => !scannedIngredients.contains(ingredient))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  if (widget.recipeModel.imagePath != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16)),
                      child: Image.asset(
                        widget.recipeModel.imagePath ?? '',
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      widget.recipeModel.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  missingIngredients.length == 1 ?
                  const Text('') 
                  :
                    Text(
                      'Missing Ingredients: $missingIngredients',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.white60
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Preparation time:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${widget.recipeModel.preperationTime} mins',
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDetailsSection('Ingredients', widget.recipeModel.ingredients),
                  const SizedBox(height: 10),
                  _buildDetailsSection('Instructions', widget.recipeModel.instructions),
                  const SizedBox(height: 10),
                  _buildDetailsSection(
                      'Allergen Statement', widget.recipeModel.allergenStatement),
                  const SizedBox(height: 10),
                  _buildDetailsSection(
                      'Restriction Statement', widget.recipeModel.restrictionStatement),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 15,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Card(
        elevation: 10,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 20),
              Text(
                content,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
