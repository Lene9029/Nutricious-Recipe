import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/providers/alleres_provider.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/providers/result_Provider.dart';
import 'package:recipe_page_new/show_recommendations_page.dart';

class EditIngredientsPage extends StatefulWidget {
  const EditIngredientsPage({super.key, required this.resultData});

  final List<String> resultData;

  @override
  State<EditIngredientsPage> createState() => _EditIngredientsPageState();
}

class _EditIngredientsPageState extends State<EditIngredientsPage> {
  bool edit = true;
  TextEditingController? _textController;
  late List<bool> _selectedCondiments;

  final List<String> _condiments = [
    'Salt',
    'Sugar',
    'Fish Sauce',
    'Fish Paste',
    'Banana Ketchup',
    'Chili Garlic Sauce',
    'Mayonnaise',
    'Coconut Milk',
    'Shrimp Paste'
  ];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.resultData.join(', '));
    _selectedCondiments = List<bool>.filled(_condiments.length, false);
  }

  @override
  void dispose() {
    _textController?.dispose();
    super.dispose();
  }

  void _saveEdits() {
    setState(() {    
      widget.resultData
        ..clear()
        ..addAll(
          _textController!.text
            .split(', ') 
            .where((ingredient) => ingredient.trim().isNotEmpty)
            .toList(),
          );
      edit = false;
    });
  }


  List<String> getSelectedCondiments() {
    List<String> selectedCondiments = [];
    for (int i = 0; i < _condiments.length; i++) {
      if (_selectedCondiments[i]) {
        selectedCondiments.add(_condiments[i]);
      }
    }
    return selectedCondiments;
  }
  

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<RecipeClass>(context);
    final allergensProvider = Provider.of<AlleresProvider>(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreen,Colors.lightBlue], 
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight, )),
            child: Column(            
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
                    ],
                  ),
                ),
              const Padding(
                padding:  EdgeInsets.only(left: 25),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Text(
                      'Edit and Add Ingredients',
                        style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Card(               
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: edit
                          ? TextField(
                              controller: _textController,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                labelText: 'Edit Ingredients',
                                labelStyle: TextStyle(color: Colors.lightGreen[800]),
                              ),
                            )
                          : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              onTap: 
                              () {
                      setState(() {                      
                          edit = true;                        
                      });
                    },
                              child: Text(
                                  widget.resultData.join(', '),                         
                                ),
                            ),
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                edit ? Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (edit) {
                          _saveEdits();
                        } else {
                          edit = true;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(                    
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ) : 
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Text(
                        'Add Condiments',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,                    
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 1.0,        
                        runSpacing: 1.0,     
                        children: List<Widget>.generate(
                          _condiments.length,
                          (int index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,  
                              height: 45,                                        
                              child: CheckboxListTile(
                  title: Text(
                    _condiments[index],
                    style: const TextStyle(color: Colors.black),
                    softWrap: true, // Enable text wrapping
                    overflow: TextOverflow.visible
                  ),
                  value: _selectedCondiments[index],
                  onChanged: (bool? selected) {
                    setState(() {
                      _selectedCondiments[index] = selected ?? false;
                    });
                  },
                  activeColor: Colors.lightGreen,
                  controlAffinity: ListTileControlAffinity.leading,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )            
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent
            ),
            height: 60,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  
                  List<String> combinedData = List.from(widget.resultData);  
                  combinedData.addAll(getSelectedCondiments());

                  final resultProvider = Provider.of<ResultProvider>(context, listen: false);
                  resultProvider.updateResult(combinedData);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          Provider.value(value: myProvider.allRecipes),
                          Provider.value(value: allergensProvider.allergens),
                          Provider.value(value: allergensProvider.restrictions),
                        ],
                        child: ShowRecipeWithIngredients(
                          resultData: combinedData,
                          recipes: myProvider.allRecipes,
                          allergens: allergensProvider.allergens,
                          restrictions: allergensProvider.restrictions,
                        ),
                      ),
                    ),
                  );
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
                    'View Recipes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
