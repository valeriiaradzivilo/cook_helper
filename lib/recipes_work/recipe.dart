import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'getRecipes.dart';

class Recipe{
  String id;
  String name;
  List<dynamic> ingredients;
  String description;
  List<dynamic> steps;
  var imageUrl;
  bool isLiked;

  Recipe(this.id, this.name,this.description,this.ingredients,this.steps, this.imageUrl, this.isLiked);

  List<String> getSmallRecipe()
  {
    List<String> answer = [this.name, this.description];
    return answer;
  }

  void setLike(bool like)
  {
    isLiked = like;
  }

  Future<void> addRecipeToFirestore() async {
    // Get a reference to the Firestore collection where the recipe will be stored
    CollectionReference recipesRef = FirebaseFirestore.instance.collection('recipes');

    // Add the recipe data to the Firestore collection
    await recipesRef.doc(id).set({
      'name':name,
      'description':description,
      'ingredients':ingredients,
      'steps':steps
    });
  }



  Future<String> uploadFileImageToFirebase(File imageFile) async {
    // Reference to the storage location where the image will be uploaded
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('recipe_pictures/$id.jpg');

    // Upload the image to Firebase Storage
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    // Get the URL of the uploaded image
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    this.imageUrl = await RecipesList.resizeImage(imageUrl);

    return imageUrl;
  }

  String toString()
  {
    return "$id $name $description ${ingredients.toString()} ${steps.toString()}";
  }



}