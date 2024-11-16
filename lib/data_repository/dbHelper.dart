import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database database;
  static final DbHelper dbHelper = DbHelper();
  final String tableName = 'recipes';
  final String nameColumn = 'name';
  final String idColumn = 'id';
  final String isFavoriteColumn = 'isFavorite';
  final String ingredientsColumn = 'ingredients';
  final String instructionsColumn = 'instructions';
  final String preperationTimeColumn = 'preperationTime';
  final String imageColumn = 'image';

  final String allergensName = 'allergenName';
  final String restrictions = 'restrictions';
  final String allergenStatement = 'allergenStatement';
  final String restrictionStatement = 'restrictionStatement';
  final String otherInformations = 'otherInformations';

  Future<void> initDatabase() async {
    database = await connectToDatabase();
    
  }

   
  Future<void> addNewColumn() async {
     database = await connectToDatabase();
    database.execute('ALTER TABLE $tableName ADD COLUMN $allergenStatement TEXT');
  
    database.execute('ALTER TABLE $tableName ADD COLUMN $restrictionStatement TEXT');
  } 
      
  Future<Database> connectToDatabase() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String dbPath = join(documentsDirectory.path, 'recipes.db');

  bool dbExists = await File(dbPath).exists();

  if (!dbExists) {
    ByteData data = await rootBundle.load('assets/recipes.db');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(dbPath).writeAsBytes(bytes, flush: true);
  }

  return openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE IF NOT EXISTS $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT, $allergensName TEXT, $restrictions TEXT, $allergenStatement TEXT, $restrictionStatement TEXT, $otherInformations TEXT)',
      );
    },
    onUpgrade: (db, oldVersion, newVersion) {
      //db.execute('DROP TABLE IF EXISTS $tableName');
      db.execute(
        'CREATE TABLE IF NOT EXISTS $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT, $allergensName TEXT, $restrictions TEXT, $allergenStatement TEXT, $restrictionStatement TEXT, $otherInformations TEXT)',
      );
    },
  );
}
  
   

  Future<List<RecipeModel>> getAllRecipes() async {
    List<Map<String, dynamic>> tasks = await database.query(tableName);
    return tasks.map((e) => RecipeModel.fromMap(e)).toList();
  }

  

 Future<void> insertNewRecipe(RecipeModel recipeModel) async {
    await database.insert(tableName, recipeModel.toMap());  
  }

  Future<void> deleteRecipe(RecipeModel recipeModel) async {
    await database.delete(tableName, where: '$idColumn=?', whereArgs: [recipeModel.id]);
  }

  Future<void> deleteRecipes() async {
    await database.delete(tableName);
  }

  Future<void> updateRecipe(RecipeModel recipeModel) async {
    await database.update(
        tableName,
        {
          isFavoriteColumn: recipeModel.isFavorite ? 1 : 0,
          nameColumn: recipeModel.name,
          preperationTimeColumn: recipeModel.preperationTime,
          imageColumn: recipeModel.imagePath,
          ingredientsColumn: recipeModel.ingredients,
          instructionsColumn: recipeModel.instructions,
          allergensName: recipeModel.allergensName,
          restrictions: recipeModel.restrictions,
          allergenStatement: recipeModel.allergenStatement,
          restrictionStatement: recipeModel.restrictionStatement
        },
        where: '$idColumn=?',
        whereArgs: [recipeModel.id]);
  }
  
  Future<void> updateIsFavorite(RecipeModel recipeModel) async {
    await database.update(
        tableName, 
        {isFavoriteColumn: !recipeModel.isFavorite ? 1 : 0},
        where: '$idColumn=?', 
        whereArgs: [recipeModel.id]);
  }
}
