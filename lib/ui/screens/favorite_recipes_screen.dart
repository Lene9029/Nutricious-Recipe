import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/ui/widgets/favorites_recipe_widget.dart';
import '../../providers/recipe_provider.dart';

class FavoriteRecipesScreen extends StatelessWidget {
  const FavoriteRecipesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Favorite Recipes',
              textAlign: TextAlign.center,
              style:TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold, 
                shadows: [
                ],
              ),
            ),
                      ),
                //Padding(
                  //padding: const EdgeInsets.all(8.0),
                  //child: Container(
                       //   margin: const EdgeInsets.only(top: 5, bottom: 20),
                       //   width: MediaQuery.of(context).size.width,
                       //   height: 50,
                        //  alignment: Alignment.center,
                        //  decoration: BoxDecoration(
                       //     color: Colors.grey,
                       //     borderRadius: BorderRadius.circular(10),
                       //   ),
                        //  child: TextFormField(
                        //    decoration: InputDecoration(
                           //   border: InputBorder.none,
                          //    hintText: 'Search Recipes Here...',
                          //    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                          //    prefixIcon: const Icon(
                           //     Icons.search,
                           //     size: 25,
                           //   ),
                         //   ),
                          //  onChanged: (value) {
                          //    myProvider.filteredFavorites(value);
                          //  },
                         // ),
                       // ),
              //  ),
               Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: myProvider.favoriteRecipes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5), 
                    child: FavoritesRecipe(myProvider.favoriteRecipes[index]), 
                  );
                },
              ),
            )
            
              ],
            ),
          ),
          
        );
      },
    );
  }
}
