import 'package:cook_helper/additional_classes/color_palette.dart';
import 'package:cook_helper/authentication/user.dart';
import 'package:cook_helper/widgets/image_picker.dart';
import 'package:cook_helper/widgets/text_widgets/decription_text.dart';
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
  Recipe currentRecipe = Recipe("", "", "", [], [], "", false);
  List<dynamic> steps = [];
  List<dynamic> ingredients = [];
  List<TextEditingController> stepsControllers = [];
  List<TextEditingController> ingredientsControllers = [];
  List<TextEditingController> ingredientsAmountControllers = [];
  ColorPalette colorPalette = ColorPalette();



  @override
  void initState() {
    currentRecipe.id = User_Fire.generateRandomId();
    super.initState();
  }

  void addFieldFunc(List<List<TextEditingController>> controllers) {
    setState(() {
      for (int i = 0; i < controllers.length; i++) {
        controllers.elementAt(i).add(TextEditingController());
      }
    });
  }

  bool checkForFullControllers(List<TextEditingController> controllers)
  {
    for(int i =0; i<controllers.length;i++)
      {
        if(controllers.elementAt(i).text.isEmpty) {
          return false;
        }
      }

    return true;
  }

  Widget okButton(){
    return TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  AlertDialog alert() {
    return AlertDialog(
      title: const Text("Error"),
      content: const Text("You didn't fill all the fields"),
      actions: [
        okButton(),
      ],
    );
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
                const MainText(text: "Create your personal recipe",sizePercent: 100,),
                const DescriptionText(text: "Name"),
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
                const DescriptionText(text: "Description"),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Description",
                  ),
                ),
                const DescriptionText(text: "Ingredients"),
                for (int i = 0; i < ingredientsControllers.length; i++)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: ingredientsAmountControllers.elementAt(i),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Amount of ",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: ingredientsControllers.elementAt(i),
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: "Ingredient ${i + 1}",
                          ),
                        ),
                      ),
                    ],
                  ),

                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPalette.lightOrange,
                    ),
                    onPressed: () => addFieldFunc(
                        [ingredientsAmountControllers, ingredientsControllers]),
                    icon: const Icon(Icons.add),
                    label: const Text("Add ingredient")),

                //TODO: clean your code here to avoid repeats
                const DescriptionText(text: "Steps"),
                for (int i = 0; i < stepsControllers.length; i++)
                  TextFormField(
                    controller: stepsControllers.elementAt(i),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: "Step ${i + 1}",
                    ),
                  ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPalette.lightOrange,
                    ),
                    onPressed: () => addFieldFunc(
                        [stepsControllers]),
                    icon: const Icon(Icons.add),
                    label: const Text("Add step")),

                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPalette.bordo,
                    ),
                    onPressed: () {
                      if (ingredientsControllers.isNotEmpty &&
                          stepsControllers.isNotEmpty &&
                          currentRecipe.imageUrl != null
                      && checkForFullControllers(ingredientsControllers)
                      && checkForFullControllers(ingredientsAmountControllers)
                      && checkForFullControllers(stepsControllers)
                      ) {
                        setState(() {
                          currentRecipe.name = nameController.text;
                          currentRecipe.description =
                              descriptionController.text;
                          for (int i = 0;
                              i < ingredientsControllers.length;
                              i++) {
                            var ingr = {};
                            ingr['amount'] = double.parse(
                                ingredientsAmountControllers.elementAt(i).text);
                            ingr['item'] =
                                ingredientsControllers.elementAt(i).text;
                            currentRecipe.ingredients.add(ingr);
                          }
                          for (TextEditingController t in stepsControllers) {
                            currentRecipe.steps.add(t.text);
                          }
                          currentRecipe.uploadFileImageToFirebase(
                              currentRecipe.imageUrl);
                          currentRecipe.addRecipeToFirestore();
                        });
                      } else {
                        print("You didn't fill all the fields");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert();
                          },
                        );

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
