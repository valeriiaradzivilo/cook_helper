import 'package:cook_helper/additional_classes/color_palette.dart';
import 'package:cook_helper/authentication/login_screen.dart';
import 'package:cook_helper/authentication/user.dart';
import 'package:cook_helper/recipes_work/getRecipes.dart';
import 'package:cook_helper/screens/user_screen.dart';
import 'package:cook_helper/widgets/loading_widget.dart';
import 'package:cook_helper/widgets/small_recipe.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../authentication/auth.dart';
import '../recipes_work/recipe.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ColorPalette colorPalette = ColorPalette();
  int currentIndex = 0;
  List<Recipe> recipesList = [];
  RecipesList recipeDatabaseWork = RecipesList();
  late var currentUser;
  bool isLoaded = false;
  int biggestIndex=0;


  Future<List<Recipe>> recipeGetter(int position) async {
    position+=1;
    print("Position $position");
    print("Biggest index $biggestIndex");
    if(position>=
        biggestIndex-3) {
      recipesList = await recipeDatabaseWork.getThreeRecipes(position).whenComplete(() => isLoaded = true);
      biggestIndex += 3;
    }
    else
      {
        isLoaded = true;
      }
    return recipesList;
  }

  Future<void> signInAn() async{
  AuthService authService = AuthService();
  await authService.signInAnon();
}

  @override
  void initState() {
    signInAn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      setState(() {
        currentUser = ModalRoute.of(context)!.settings.arguments as User_Fire;
      });
    } else {
      setState(() {
        currentUser = null;
      });
    }
    return Scaffold(
        backgroundColor: colorPalette.lightBlue,
        appBar: AppBar(
          title: const Text("Cookbook Helper"),
          centerTitle: true,
          backgroundColor: colorPalette.lightBlue,
          elevation: 0.2,
          actions: [
            IconButton(
                onPressed: () {
                  if (currentUser != null) {
                    Navigator.pushNamed(context, UserScreen.routeName,
                        arguments: currentUser);
                  } else {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  }
                },
                icon: const Icon(Icons.person_outline))
          ],
          leading: IconButton(
              onPressed: () {
                if (currentUser != null) {
                  Navigator.pushNamed(context, UserScreen.routeName,
                      arguments: currentUser);
                } else {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                }
              },
              icon: const Icon(Icons.search_outlined)),
        ),
        body: FutureBuilder<List<Recipe>>(
          future: recipeGetter(currentIndex),
          builder: (context, snapshot) {
            if (snapshot.hasError && isLoaded) {
              return const Center(
                child: Text("ERROR"),
              );
            }
            if (snapshot.hasData && isLoaded) {
              return SafeArea(
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: colorPalette.lightOrange,
                            width: 10.w,
                            height: 60.h,
                          ),
                          Dismissible(
                            resizeDuration: const Duration(milliseconds: 10),
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                if (currentIndex != 0) {
                                  currentIndex +=
                                      direction == DismissDirection.endToStart
                                          ? 1
                                          : -1;
                                }
                                else{
                                  currentIndex +=
                                  direction == DismissDirection.endToStart
                                      ? 1
                                      : 1;
                                }
                                if(currentIndex>biggestIndex)
                                  {
                                    biggestIndex=currentIndex;
                                  }
                                if(currentIndex==recipesList.length-3)
                                  {
                                    recipeGetter(currentIndex);
                                  }
                                if(currentIndex==recipesList.length-1)
                                  {
                                    isLoaded = false;
                                  }

                              });
                            },
                            key: ValueKey(currentIndex),
                            child: SmallRecipe(
                                recipe: recipesList.elementAt(currentIndex)),
                          ),
                          Container(
                            color: colorPalette.lightOrange,
                            width: 10.w,
                            height: 60.h,
                          ),
                        ],
                      )));
            } else {
              return const LoadingWidget();
            }
          },
        ));
  }
}
