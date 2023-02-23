import 'package:cook_helper/recipes_work/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
        backgroundColor: Color(0xFF9FB4E7),
        leading: IconButton(onPressed: (){}, icon:
        Icon(Icons.search_outlined)),
        leadingWidth: 90,
        actions: [
          IconButton(onPressed: (){}, icon:
          Icon(Icons.person_outline)),
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
                    Text(currentRecipe.name, style: TextStyle(fontSize: 30),),
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
                Text(currentRecipe.description),
                Text("Components:"),
                for(int i =0; i<currentRecipe.ingredients.length;i++)
                  Row(
                    children: [
                      Text(currentRecipe.ingredients.elementAt(i)['amount'].toString()),
                      Spacer(),
                      Text(currentRecipe.ingredients.elementAt(i)['item']),
                    ],
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
