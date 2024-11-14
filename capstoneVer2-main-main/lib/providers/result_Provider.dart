import 'package:flutter/material.dart';

class ResultProvider extends ChangeNotifier {
  List<String> resultData = [];

  
  void updateResult(List<String> newResultData) {
    resultData = newResultData; 
    notifyListeners();          
  }
}
