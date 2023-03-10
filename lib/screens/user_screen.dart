import 'package:cook_helper/additional_classes/color_palette.dart';
import 'package:cook_helper/authentication/user.dart';
import 'package:cook_helper/recipes_work/getRecipes.dart';
import 'package:cook_helper/widgets/favourite_search_recipe.dart';
import 'package:cook_helper/widgets/small_recipe.dart';
import 'package:cook_helper/widgets/text_widgets/decription_text.dart';
import 'package:cook_helper/widgets/text_widgets/main_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../recipes_work/recipe.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  static const routeName = '/selectUser';

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  ColorPalette colorPalette = ColorPalette();
  RecipesList recipesList = RecipesList();
  User_Fire? currentUser;
  List<Recipe>? UsersRecipes;
  bool gotRecipes = false;
  String warningLoadingText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentUser = ModalRoute.of(context)!.settings.arguments as User_Fire;
    return Scaffold(
      backgroundColor: colorPalette.lightBlue,
      appBar: AppBar(
        title: const Text("Your profile"),
        centerTitle: true,
        backgroundColor: colorPalette.lightOrange,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Icon(
                Icons.person_outlined,
                size: 60,
                color: colorPalette.bordo,
              ),
              MainText(
                text: currentUser!.username!,
                sizePercent: 100,
              ),
              Row(
                children: [
                  const MainText(
                    text: "Favourites",
                    sizePercent: 60,
                  ),
                  IconButton(
                      onPressed: () async {
                        if (gotRecipes == false) {
                          UsersRecipes = await RecipesList.getRecipesUser(
                              currentUser!.favouritesId!);
                        } else {
                          setState(() {
                            UsersRecipes = null;
                          });
                        }
                        setState(() {
                          gotRecipes = !gotRecipes;
                        });
                      },
                      icon: Icon(!gotRecipes
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up)),
                ],
              ),
              if(gotRecipes==true && UsersRecipes!.isEmpty)
                const DescriptionText(text:"There are no favourites yet. Go to main screen and find what you like.",),
              if (gotRecipes == true)
                for (int i = 0; i < UsersRecipes!.length; i++)
                  Container(
                      width: 100.w,
                      height: 20.h,
                      child:
                          FavouriteRecipe(recipe: UsersRecipes!.elementAt(i))),
              currentUser!.isCreator
                  ? ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorPalette.pink
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.add_box_outlined),
                      label: Text("Add new recipe to catalog"))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
