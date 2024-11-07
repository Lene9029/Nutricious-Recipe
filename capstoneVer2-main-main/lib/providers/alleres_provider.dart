import 'package:flutter/material.dart';

class AlleresProvider extends ChangeNotifier {
  List<String> allergens = [];
  List<String> restrictions =[];

  

  void updateAllergens(List<String> selectedAllergens) {
    allergens = selectedAllergens;
    notifyListeners();
  }

  void updateRestrictions(List<String> selectedRestrictions) {
    restrictions = selectedRestrictions;
    notifyListeners();
  }
}
