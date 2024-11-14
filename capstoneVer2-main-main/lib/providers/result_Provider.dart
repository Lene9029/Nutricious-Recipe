import 'package:flutter/material.dart';

class ResultProvider extends ChangeNotifier {
  late List<String> resultData = [];

  
  void updateResult(List<String> newResultData) {
    resultData = newResultData; 
    notifyListeners();          
  }
}
