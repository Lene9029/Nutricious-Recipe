import 'dart:io';

class RecipeModel {
  int? id;
  late String name;
  late bool isFavorite;
  late String? imagePath;
  late int ?preperationTime;
  late String ingredients;
  late String instructions;

  
  late String allergensName;
  late String restrictions;
  late String allergenStatement;
  late String restrictionStatement;
  late String otherInformations;


  RecipeModel({
    this.id,
    required this.name,
    required this.isFavorite,
    this.imagePath,
    required this.preperationTime,
    required this.ingredients,
    required this.instructions,

    
   required this.allergensName,
   required this.restrictions,
   required this.allergenStatement,
   required this.restrictionStatement,
   required this. otherInformations
   
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isFavorite': isFavorite ? 1 : 0,
      'preperationTime': preperationTime,
      'ingredients': ingredients,
      'instructions': instructions,
      'image': imagePath,
      'allergenName': allergensName,
      'restrictions': restrictions,
      'allergenStatement': allergenStatement,
      'restrictionStatement': restrictionStatement,
      'otherInformations': otherInformations
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
        id: map['id'],
        name: map['name'] ?? '',
        isFavorite: map['isFavorite'] == 1 ? true : false,
        preperationTime: map['preperationTime'],
        ingredients: map['ingredients'] ?? '',
        instructions: map['instructions'] ?? '',
        allergensName: map['allergenName'] ?? '',
        restrictions: map['restrictions'] ?? '',
        allergenStatement: map['allergenStatement'] ?? '',
        restrictionStatement: map['restrictionStatement'] ?? '',
        otherInformations: map['otherInformations'],
        imagePath: map['image']);
        
  }
}
