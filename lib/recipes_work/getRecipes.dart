import 'package:cook_helper/recipes_work/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
      recipesList.add(Recipe(document.id,data['name'], data['description'],
          data['ingredients'], data['steps'], downloadUrl,false));
    }
    return recipesList;
  }
}
