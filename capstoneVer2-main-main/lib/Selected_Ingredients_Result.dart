import 'package:flutter/material.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:recipe_page_new/ui/widgets/recipe_widget.dart';


class SelectedIngredientsResult extends StatefulWidget {
  SelectedIngredientsResult({
    super.key,
    required this.recipes,
    required this.resultData,
    required this.allergens,
    required this.restrictions
  });

  State<SelectedIngredientsResult> createState() => _SearchRecipeScreenState();

  final List<RecipeModel> recipes;
  List<RecipeModel> filteredRecipes = [];
  late List<String> resultData;
  List<RecipeModel> filteredRecipe = [];
  final  List<String> allergens;
  final List<String> restrictions;
 
}

class _SearchRecipeScreenState extends State<SelectedIngredientsResult> {
  late List<RecipeModel> _filteredRecipes;
  List<RecipeModel> _filteredRecipe = [];
  
  List<RecipeModel> filteredFinal = []; 
  List<RecipeModel> filteredrestrictions = []; 
  List<RecipeModel> filteredA = [];
  List<RecipeModel> filteredR = []; 

  void filterRecipe(String value) {
    setState(() {
      _filteredRecipes = filteredFinal
          .where((recipe) =>
              recipe.ingredients.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

    _filterRecipes(List<String> resultData) {
  setState(() {
   _filteredRecipes = widget.recipes.where((recipe) {
  return resultData.any((ingredient) {
    final pattern = RegExp(r'\b' + RegExp.escape(ingredient) + r'\b', caseSensitive: false);
    return pattern.hasMatch(recipe.ingredients);
  });
}).toList();

    if (widget.restrictions.isNotEmpty) {
      _filteredRecipes = _filteredRecipes.where((recipe) {
        return widget.restrictions.any((restriction) =>
            recipe.restrictions.toLowerCase().contains(restriction.toLowerCase()));
      }).toList();
    }

    if (widget.allergens.isNotEmpty) {
      _filteredRecipes = _filteredRecipes.where((recipe) {
        return !widget.allergens.any((allergen) =>
            recipe.allergensName.toLowerCase().contains(allergen.toLowerCase()));
      }).toList();
    }
    filteredFinal = _filteredRecipes.toSet().toList();
  });
}


  @override
  void initState() {
    _filterRecipes(widget.resultData);
    super.initState();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Stack(
        children: [Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'Recommended Recipes',
                textAlign: TextAlign.center,
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.only(top: 5, bottom: 20),
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  elevation: 5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Recipes Here...',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                    onChanged: (value) {
                      filterRecipe(value);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: filteredFinal.isNotEmpty
                    ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 185,
                        ),
                        itemCount: filteredFinal.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RecipeWidget(filteredFinal[index]);
                        },
                      )
                    : const Center(
                        child: Text('Recipe not found...'),
                      ),
              ),
            ),
          ],
        ),
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.black,),
                          onPressed: () => Navigator.pop(context),
                          ),
              ),
        ]
      ),
    ),
  );
}
}