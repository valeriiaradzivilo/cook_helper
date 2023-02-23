import 'package:cook_helper/recipes_work/recipe.dart';
import 'package:cook_helper/widgets/text_widgets/decription_text.dart';
import 'package:cook_helper/widgets/text_widgets/main_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/text_widgets/SmallText.dart';

class OpenRecipeScreen extends StatefulWidget {
  const OpenRecipeScreen({Key? key}) : super(key: key);
  static const routeName = '/openRecipe';
  @override
  State<OpenRecipeScreen> createState() => _OpenRecipeScreenState();
}

class _OpenRecipeScreenState extends State<OpenRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentRecipe = ModalRoute.of(context)!.settings.arguments as Recipe;
    return Scaffold(
      appBar: AppBar(
        title: Text(currentRecipe.name.toUpperCase()),
        centerTitle: true,
        backgroundColor: const Color(0xFF9FB4E7),
        leading: IconButton(onPressed: (){}, icon:
        const Icon(Icons.search_outlined)),
        leadingWidth: 90,
        actions: [
          IconButton(onPressed: (){}, icon:
          const Icon(Icons.person_outline)),
        ],
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                    height: 50.h,
                    child: Image.network(currentRecipe.imageUrl)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainText(text: currentRecipe.name),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentRecipe.isLiked = !currentRecipe.isLiked;
                        });
                      },
                      iconSize: 40,
                      icon: Icon(
                        CupertinoIcons.heart,
                        color: currentRecipe.isLiked ? const Color(0xFF9D5C63) : null,
                      ),
                    ),
                  ],
                ),
                DescriptionText(text:currentRecipe.description),
                const MainText(text:"Components:"),
                for(int i =0; i<currentRecipe.ingredients.length;i++)
                  Row(
                    children: [
                      SmallText(text:currentRecipe.ingredients.elementAt(i)['amount'].toString()),
                      const Spacer(),
                      SmallText(text:currentRecipe.ingredients.elementAt(i)['item']),
                    ],
                  ),
                const MainText(text: "Recipe"),
                for(int i =0; i<currentRecipe.steps.length;i++)
                      RichText(
                        text: TextSpan(
                          text: 'Step ${i+1}\n\n',
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),
                          children: [
                            TextSpan(text: "${currentRecipe.steps.elementAt(i)}\n", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16))
                          ],
                        ),
                      ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
