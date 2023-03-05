import 'dart:typed_data';

import 'package:cook_helper/recipes_work/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


  Future<List<Recipe>> getRecipesUser(List<dynamic> favouritesId) async {


    recipesList.clear();
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('recipes');
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    // Get a reference to the Firebase Storage service
    final storage = FirebaseStorage.instance;

    for (QueryDocumentSnapshot document in documents) {
      if(favouritesId.contains(document.id)) {
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
}
