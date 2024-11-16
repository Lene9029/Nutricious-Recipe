import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/NavigationBar.dart';
import 'package:recipe_page_new/providers/alleres_provider.dart';

class SelectAllergiesdietsPage extends StatefulWidget {
  const SelectAllergiesdietsPage({super.key});

  @override
  State<SelectAllergiesdietsPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SelectAllergiesdietsPage> {
  final List<String> _allergenchoices = [
    'Barley', 'Celeriac', 'Celery', 'Citrus fruit', 'Corn', 'Egg', 'Fish', 
    'Latex', 'Lupin', 'Milk', 'Mustard', 'Nickel allergy', 'Oats', 
    'Oral allergy syndrome', 'Peanut', 'Rice', 'Rye', 'Seeds', 'Sesame', 
    'Shellfish', 'Soy', 'Tree nut', 'Wheat'
  ];

  final List<String> restrictionsChoices = [
    'Alpha gal', 'Autoimmune protocol', 'Breastfeeding', 'Candida overgrowth', 
    'Citric acid intolerance', 'Dairy free', 'Egg free', 'Emulsifier free', 
    'Eosinophilic esophagitis', 'Fructose free', 'Gerd', 'Gluten free', 
    'Interstitial cystitis', 'Lactose free', 'Low fodmap', 'Low histamine', 
    'Low iodine', 'Low residue', 'Mediterranean diet', 'No beef', 'No pork', 
    'Paleo', 'Pescatarian', 'Plantricious', 'Polycystic ovary syndrome', 
    'Pregnancy', 'Vegan', 'Vegetarian', '30 paleo days'
  ];

  late List<bool> _selectedAllergenChoices;
  late List<bool> _selectedRestrictionsChoices;

  @override
  void initState() {
    super.initState();
    _selectedAllergenChoices = List<bool>.filled(_allergenchoices.length, false);
    _selectedRestrictionsChoices = List<bool>.filled(restrictionsChoices.length, false);
  }

  List<String> getSelectedAllergens() {
    List<String> selectedAllergenChoices = [];
    for (int i = 0; i < _allergenchoices.length; i++) {
      if (_selectedAllergenChoices[i]) {
        selectedAllergenChoices.add(_allergenchoices[i]);
      }
    }
    return selectedAllergenChoices;
  }

  List<String> getSelectedRestrictions() {
    List<String> selectedRestrictionsChoices = [];
    for (int i = 0; i < restrictionsChoices.length; i++) {
      if (_selectedRestrictionsChoices[i]) {
        selectedRestrictionsChoices.add(restrictionsChoices[i]);
      }
    }
    return selectedRestrictionsChoices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/allergy.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 40),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                        child: Container(
                          color: Colors.grey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  'What Are Your Allergies?',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Wrap(
                                  spacing: 1.0,
                                  runSpacing: 1.0,
                                  children: List<Widget>.generate(
                                    _allergenchoices.length,
                                    (int index) {
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width / 2 - 30,
                                        height: 45,
                                        child: CheckboxListTile(
                                          title: Text(
                                            _allergenchoices[index],
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          value: _selectedAllergenChoices[index],
                                          onChanged: (bool? selected) {
                                            setState(() {
                                              _selectedAllergenChoices[index] = selected ?? false;
                                            });
                                          },
                                          activeColor: Colors.green,
                                          controlAffinity: ListTileControlAffinity.leading,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                        child: Container(
                          color: Colors.grey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  'What Are Your Diets?',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Wrap(
                                  spacing: 1.0,
                                  runSpacing: 1.0,
                                  children: List<Widget>.generate(
                                    restrictionsChoices.length,
                                    (int index) {
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width / 2 - 30,
                                        height: 52,
                                        child: CheckboxListTile(
                                          title: Text(
                                            restrictionsChoices[index],
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          value: _selectedRestrictionsChoices[index],
                                          onChanged: (bool? selected) {
                                            setState(() {
                                              _selectedRestrictionsChoices[index] = selected ?? false;
                                            });
                                          },
                                          activeColor: Colors.green,
                                          controlAffinity: ListTileControlAffinity.leading,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                List<String> allergens = getSelectedAllergens();
                List<String> restrictions = getSelectedRestrictions();
        
                print(restrictions);
                print(allergens);
        
                final alleresProvider = Provider.of<AlleresProvider>(context, listen: false);
                alleresProvider.updateAllergens(allergens);
                alleresProvider.updateRestrictions(restrictions);
        
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
              },
              child: Container(
                height: 50,  
                width: 350,  
                decoration: BoxDecoration(
                  color: Colors.lightGreen,  
                  borderRadius: BorderRadius.circular(12),  
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                alignment: Alignment.center,  
                child: const Text(
                  'Save Selections',
                  style: TextStyle(
                    color: Colors.white,  
                    fontSize: 18,  
                    fontWeight: FontWeight.bold,  
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
