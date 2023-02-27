import 'dart:math';

import 'package:cook_helper/widgets/image_picker.dart';
import 'package:cook_helper/widgets/text_widgets/decription_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import '../recipes_work/recipe.dart';
import '../widgets/text_widgets/main_text_widget.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Recipe currentRecipe = Recipe("","", "", [], [], "", false);
  List<dynamic> steps = [];
  List<dynamic> ingredients = [];
  List<TextEditingController> stepsControllers = [];
  List<TextEditingController> ingredientsControllers = [];
  List<TextEditingController> ingredientsAmountControllers = [];


  String generateRandomId() {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String charsList =
        List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join();
    return '${DateTime.now().millisecondsSinceEpoch}$charsList';
  }



  @override
  void initState() {
    currentRecipe.id = generateRandomId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9FB4E7),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                DescriptionText(text:"Name"),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Name",
                  ),
                ),
                ImagePicker(
                  currentRecipe: currentRecipe,
                ),
                DescriptionText(text:"Description"),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Description",
                  ),
                ),
                DescriptionText(text:"Ingredients"),
                for(int i =0; i< ingredientsControllers.length;i++)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: ingredientsAmountControllers.elementAt(i),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Amount of ",
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: ingredientsControllers.elementAt(i),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Ingredient ${i+1}",
                          ),
                        ),
                      ),
                    ],
                  ),
                ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        ingredientsControllers.add(TextEditingController());
                        ingredientsAmountControllers.add(TextEditingController());
                      });

                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add ingredient")),

                //TODO: clean your code here to avoid repeats
                DescriptionText(text:"Steps"),
                for(int i =0; i< stepsControllers.length;i++)
                  TextFormField(
                    controller: stepsControllers.elementAt(i),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Step ${i+1}",
                    ),
                  ),
                ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        stepsControllers.add(TextEditingController());
                      });

                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add step")),

                ElevatedButton.icon(
                    onPressed: () {
                      print(currentRecipe.toString());
                      if(ingredientsControllers.isNotEmpty&&stepsControllers.isNotEmpty
                      &&currentRecipe.imageUrl!=null) {
                        setState(() {
                          currentRecipe.name = nameController.text;
                          currentRecipe.description =
                              descriptionController.text;
                          for (int i =0; i<ingredientsControllers.length;i++) {
                            var ingr = new Map();
                            ingr['amount'] = double.parse(ingredientsAmountControllers.elementAt(i).text);
                            ingr['item'] = ingredientsControllers.elementAt(i).text;
                            currentRecipe.ingredients.add(ingr);
                          }
                          for (TextEditingController t in stepsControllers) {
                            currentRecipe.steps.add(t.text);
                          }
                          currentRecipe.uploadFileImageToFirebase(currentRecipe
                              .imageUrl);
                          currentRecipe.addRecipeToFirestore();
                        });
                      }
                      else{
                        print("You didn't fill all the fields");
                      }


                    },
                    icon: const Icon(Icons.save_alt),
                    label: const Text("Save recipe"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
