import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/Selected_Ingredients_Result.dart';
import 'package:recipe_page_new/providers/alleres_provider.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';

class SelectIngredientsPage extends StatefulWidget {
  const SelectIngredientsPage({super.key});

  @override
  State<SelectIngredientsPage> createState() => _SeelecIgredientsPageState();
}

class _SeelecIgredientsPageState extends State<SelectIngredientsPage> {
  final List<String> _meatIngredients = [
    'beef meat', 'beef intestines', 'beef kidney', 'beef ribs', 'beef tail', 
    'beef tripe', 'chicken', 'pork heart', 'pork liver', 'pork loin', 
    'pork lung', 'pork meat', 'pork ribs', 'pork shoulder', 'pork skin','egg'
  ];

  final List<String> _fruitVegIngredients = [
    'ampalaya', 'bangus', 'bay leaves', 'bokchoy', 'broccoli', 'calamansi', 
    'cauliflower', 'celery', 'chayote', 'eggplant', 'garlic', 'ginger', 
    'green beans', 'kangkong', 'lemon', 'malungay leaves', 'mung beans', 
    'okra', 'onion', 'parsley', 'potato', 'spinach', 'spring onions', 
    'tomato',
  ];

  late List<bool> _selectedMeatChoices;
  late List<bool> _selectedFruitVegChoices;

  @override
  void initState() {
    super.initState();
    _selectedMeatChoices = List<bool>.filled(_meatIngredients.length, false);
    _selectedFruitVegChoices = List<bool>.filled(_fruitVegIngredients.length, false);
  }

  List<String> getSelectedIngredients() {
    List<String> selectedIngredients = [];

    for (int i = 0; i < _meatIngredients.length; i++) {
      if (_selectedMeatChoices[i]) {
        selectedIngredients.add(_meatIngredients[i]);
      }
    }

    for (int i = 0; i < _fruitVegIngredients.length; i++) {
      if (_selectedFruitVegChoices[i]) {
        selectedIngredients.add(_fruitVegIngredients[i]);
      }
    }

    return selectedIngredients;
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<RecipeClass>(context);
    final allergensProvider = Provider.of<AlleresProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Choose Your Ingredients',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1.0),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Meat Ingredients',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 1.0,
                                  children: List<Widget>.generate(
                                      _meatIngredients.length, (int index) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width / 2 - 11,
                                      height: 50,
                                      child: CheckboxListTile(
                                        title: Text(
                                          _meatIngredients[index],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        value: _selectedMeatChoices[index],
                                        onChanged: (bool? selected) {
                                          setState(() {
                                            _selectedMeatChoices[index] =
                                                selected ?? false;
                                          });
                                        },
                                        activeColor: Colors.green,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                    );
                                  }),
                                ),
                              
                                const SizedBox(height: 20),
                                const Text(
                                  'Fruits & Vegetables',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 1.0,
                                  children: List<Widget>.generate(
                                      _fruitVegIngredients.length,
                                      (int index) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width / 2 - 11,
                                      height: 45,
                                      child: CheckboxListTile(
                                        title: Text(
                                          _fruitVegIngredients[index],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        value: _selectedFruitVegChoices[index],
                                        onChanged: (bool? selected) {
                                          setState(() {
                                            _selectedFruitVegChoices[index] =
                                                selected ?? false;
                                          });
                                        },
                                        activeColor: Colors.green,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          ElevatedButton(
                            onPressed: () {
                              var resultData = getSelectedIngredients();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MultiProvider(
                                    providers: [
                                      Provider.value(
                                          value: myProvider.allRecipes),
                                      Provider.value(
                                          value: allergensProvider.allergens),
                                      Provider.value(
                                          value: allergensProvider.restrictions),
                                    ],
                                    child: SelectedIngredientsResult(
                                      resultData: resultData,
                                      recipes: myProvider.allRecipes,
                                      allergens: allergensProvider.allergens,
                                      restrictions: allergensProvider.restrictions,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text('Submit Ingredients'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
