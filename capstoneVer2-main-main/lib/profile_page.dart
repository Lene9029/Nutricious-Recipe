import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/select_AllergiesDiets_Page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<RecipeClass>(context); 
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: myProvider.isDark ? Colors.grey[850] : Colors.brown,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
        Image.asset(
          'images/profilebackground.jpg',
          fit: BoxFit.cover, 
        ),
        const Center(
          child: CircleAvatar(
            backgroundImage: AssetImage('images/logo.png'),
            radius: 70,
          ),
        ),
            ],
          ),
        ),
        
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Change Allergens and Restrictions'),
                    leading: const Icon(
                      Icons.change_circle_outlined,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectAllergiesdietsPage()));
                    },
                  ),
                  //myProvider.isDark
                    //  ? ListTile(
                     //     title: const Text('Change Theme'),
                     //     leading: const Icon(
                     //       Icons.light_mode_outlined,
                     //       color: Colors.black,
                     //     ),
                     //     onTap: () {
                   //         Provider.of<RecipeClass>(context, listen: false).changeIsDark();
                              
                    //      },
                   //     )
                  //    : ListTile(
                  //        title: const Text('Change Theme'),
                  //        leading: const Icon(
                  //          Icons.dark_mode_outlined,
                  //          color: Colors.black,
                  //        ),
                   //       onTap: () {
                   //         Provider.of<RecipeClass>(context, listen: false).changeIsDark();
                            
                   //       },
                  //      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
