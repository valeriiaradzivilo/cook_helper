import 'package:cook_helper/recipes_work/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipesList{
  late List<Recipe> recipesList;

  Future<void> getRecipes() async
  {
    recipesList.clear();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('messages');
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (QueryDocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      recipesList.add(Recipe(data['name'], data['description'], data['ingredients'], data['steps']));
      print(recipesList.last);
    }

  }




}