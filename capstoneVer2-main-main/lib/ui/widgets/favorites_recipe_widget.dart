import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/ui/screens/show_recipe_screen.dart';

import '../../models/recipe_model.dart';

class FavoritesRecipe extends StatelessWidget {
  final RecipeModel recipeModel;

  const FavoritesRecipe(this.recipeModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) =>
                      ShowRecipeScreen(recipeModel: recipeModel))));
        }),
        child: Container(
          decoration: BoxDecoration(
              color: !Provider.of<RecipeClass>(context).isDark
                  ? Colors.lightGreen
                  : null,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(5),
          child: ListTile(
            tileColor: !Provider.of<RecipeClass>(context).isDark
                ? Colors.blue[100]
                : null,
            leading: recipeModel.imagePath == null
                ? Container(
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? const Color.fromARGB(255, 167, 90, 62)
                            : null,
                        borderRadius: BorderRadius.circular(8)),
                    height: double.infinity,
                    width: 100,
                    child: const Center(
                        child: CircleAvatar(
                      backgroundImage: AssetImage('images/logo.png'),
                    )))
                : Image.asset(
                    recipeModel.imagePath ?? '',
                    width: 100,
                    height: double.infinity,
                  ),
            title: Text(recipeModel.name),
            subtitle: Text('${recipeModel.preperationTime} mins'),
            trailing: InkWell(
              onTap: () {
                Provider.of<RecipeClass>(context, listen: false)
                    .updateIsFavorite(recipeModel);
              },
              child: recipeModel.isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}