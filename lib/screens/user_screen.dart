import 'package:cook_helper/additional_classes/color_palette.dart';
import 'package:cook_helper/authentication/user.dart';
import 'package:cook_helper/recipes_work/getRecipes.dart';
import 'package:cook_helper/widgets/text_widgets/main_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../recipes_work/recipe.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  static const routeName = '/selectUser';

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  ColorPalette colorPalette = ColorPalette();
  List<Recipe> favouriteRecipes = [];
  RecipesList recipesList = RecipesList();
  late User_Fire currentUser;
  bool isLoaded = false;


  @override
  void initState() {
    setState(() {
      currentUser = ModalRoute.of(context)!.settings.arguments as User_Fire;
      favouriteRecipes = recipesList.getRecipesUser(currentUser.favouritesId!) as List<Recipe>;
      isLoaded = true;
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      replacement: CircularProgressIndicator(),
      child: Scaffold(
        backgroundColor: colorPalette.lightBlue,
        appBar: AppBar(
          title: const Text("User"),
          centerTitle: true,
          backgroundColor: colorPalette.lightWhite,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.person_outlined,
                size: 60,
                color: colorPalette.bordo,),
                MainText(text: currentUser.username!,sizePercent: 100,),
                Row(
                  children: [
                    const MainText(text: "Favourites",sizePercent: 60,),
                    Icon(CupertinoIcons.heart,
                      size: 40,
                      color: colorPalette.bordo,),
                  ],
                ),

                for(int i =0;i<currentUser.favouritesId!.length;i++)
                  Text(favouriteRecipes.elementAt(i).name),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
