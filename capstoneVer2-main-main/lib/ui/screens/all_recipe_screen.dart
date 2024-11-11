
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/NavigationBar.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/ui/widgets/recipe_widget.dart';

class MainRecipeScreen extends StatefulWidget {
  const MainRecipeScreen({super.key});

  @override
  State<MainRecipeScreen> createState() => _MainRecipeScreenState();
}

class _MainRecipeScreenState extends State<MainRecipeScreen> {
  List<RecipeModel> filtered = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
               const SizedBox(height: 10),

            Card(
              elevation: 5,
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                  20
              )),
              child: Container(
                  height: 200,
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: BoxDecoration(
                    image: const DecorationImage(image: AssetImage('images/food.jpg'), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(
                      20
                    ),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      
                      const Padding(
                        padding: EdgeInsets.only(left: 3, bottom: 15),
                          
                        
                      ),
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                            myProvider.filterAllRecipes(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            const SizedBox(height: 5,),
            const Text(
                            'All Recipes',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              wordSpacing: 2,
                              color: Colors.black,
                            ),
                          ),
              Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 10, 
              mainAxisSpacing: 10,
              mainAxisExtent: 185
            ),
            itemCount: myProvider.allRecipes.length, 
            itemBuilder: (context, index) {
              return RecipeWidget(myProvider.allRecipes[index]); 
            },
          ),
                ),
                
            ],
          ),
        ),
      ),
    );
  }
}
