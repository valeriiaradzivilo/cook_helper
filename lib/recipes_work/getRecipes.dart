import 'dart:typed_data';

import 'package:cook_helper/recipes_work/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sizer/sizer.dart';

class RecipesList {
  List<Recipe> recipesList = [];

  Future<List<Recipe>> getRecipes() async {


    recipesList.clear();
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('recipes');
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    // Get a reference to the Firebase Storage service
    final storage = FirebaseStorage.instance;

    for (QueryDocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      // Get a reference to the image file in Firebase Storage
      final imageRef = storage.ref().child('recipe_pictures/${document.id}.jpg');
      // Get the download URL of the image file
      final downloadUrl = await imageRef.getDownloadURL();
      Uint8List imageToRecipe = await resizeImage(downloadUrl);
      recipesList.add(Recipe(document.id,data['name'], data['description'],
          data['ingredients'], data['steps'], imageToRecipe,false));
    }
    return recipesList;
  }

  Future<List<Recipe>> getThreeRecipes(int position) async {
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('recipes');
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    // Get a reference to the Firebase Storage service
    final storage = FirebaseStorage.instance;

    int till = documents.length;

    for(int i =0; i<3;i++)
      {
        if(position+i>=till)
          {
            position = 0;
          }
        else
          {
            position+=i;
          }

        QueryDocumentSnapshot ourDoc = documents.elementAt(position);
        Map<String, dynamic> data = ourDoc.data() as Map<String, dynamic>;

        final imageRef = storage.ref().child('recipe_pictures/${ourDoc.id}.jpg');
        // Get the download URL of the image file
        final downloadUrl = await imageRef.getDownloadURL();
        Uint8List imageToRecipe = await RecipesList.resizeImage(downloadUrl);

        Recipe newRecipe = Recipe(ourDoc.id, data['name'], data['description'], data['ingredients'], data['steps'], imageToRecipe,false);
        recipesList.add(newRecipe);
      }

    return recipesList;

  }

  static Future<Uint8List> resizeImage(ImageUrl) async {
    Uint8List targetlUinit8List;
    Uint8List originalUnit8List;
    String imageUrl = ImageUrl;
    http.Response response = await http.get(Uri.parse(imageUrl));
    originalUnit8List = response.bodyBytes;
    var codecNew = await ui.instantiateImageCodec(originalUnit8List,
        targetHeight: (40.h).toInt());
    var frameInfoNew = await codecNew.getNextFrame();
    ui.Image targetUiImage = frameInfoNew.image;
    ByteData? targetByteData =
    await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
    targetlUinit8List = targetByteData!.buffer.asUint8List();
    return targetlUinit8List;
  }


  static Future<List<Recipe>> getRecipesUser(List<dynamic> favouritesId) async {
    List<Recipe> recipesList = [];
    List <String> newFavourites = [];
    for(var i in favouritesId)
      {
        newFavourites.add(i.toString());
      }
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('recipes');
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    // Get a reference to the Firebase Storage service
    final storage = FirebaseStorage.instance;

    for (QueryDocumentSnapshot document in documents) {
      if(newFavourites.contains(document.id.toString())) {
        print("gotta favourite recipe");
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        // Get a reference to the image file in Firebase Storage
        final imageRef =
            storage.ref().child('recipe_pictures/${document.id}.jpg');
        // Get the download URL of the image file
        final downloadUrl = await imageRef.getDownloadURL();
        Uint8List imageToRecipe = await resizeImage(downloadUrl);
        recipesList.add(Recipe(document.id, data['name'], data['description'],
            data['ingredients'], data['steps'], imageToRecipe, false));
      }
    }
    return recipesList;
  }

  static bool checkIfListContains(String valueToCheck, List<String> list)
  {
    for(String i in list)
      {
        if(i==valueToCheck)
          {
            return true;
          }
      }
    return false;
  }

}
