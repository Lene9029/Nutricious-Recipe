import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'edit_recipe_screen.dart';

class ShowRecipeScreen extends StatelessWidget {
  final RecipeModel recipeModel;

  const ShowRecipeScreen({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: ((context, provider, child) => Scaffold(
            body: SafeArea(
              child: Stack(
                children: [ SingleChildScrollView(
                  child: Positioned(
                    left: 0,
                    right: 0,
                    top: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        if (recipeModel.imagePath != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                            child: Image.asset(
                              recipeModel.imagePath ?? '',
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          const SizedBox(
                            height: 10,
                          ),
                        
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            recipeModel.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: !Provider.of<RecipeClass>(context).isDark
                                    ? Colors.white60
                                    : null,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                const Text(
                                  'Preparation time:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${recipeModel.preperationTime} mins',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildDetailsSection(
                            'Ingredients', recipeModel.ingredients),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildDetailsSection(
                            'Instructions', recipeModel.instructions),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildDetailsSection(
                            'Allergen Statement', recipeModel.allergenStatement),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildDetailsSection('Restriction Statement',
                            recipeModel.restrictionStatement),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                      
                Positioned(
                  top: 10,
                  left: 15,
                  child: Stack(
                    children: [Opacity(
                      opacity: 0.2,
                      child: Container(  
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black
                        ),
                        child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white,)),                               
                      ),
                    ),
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white,),
                        onPressed: () => Navigator.pop(context),
                        ),
                        //Positioned(
                          //bottom: MediaQuery.of(context).size.height * 0.5,
                          //child: ClipPath(
                           // clipper: MyClipper(),
                            //child: Container(
                            //  width: double.infinity,
                             // height: 300,
                            //),
                          //),
                        //)
                ]),
                )                  
                ]
              ),
            ),
          )),
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
                    fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//class MyClipper extends CustomClipper<Path> {
  //@override
  //Path getClip(Size size) {
   //var path = Path();
    //path.lineTo(0, size.height);
    //path.lineTo(size.width, size.height);
    //path.quadraticBezierTo(0, size.height, 0, 0);
    //return path;
 // }

 // @override
  //bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
  //  return false;
  //}

  
//}