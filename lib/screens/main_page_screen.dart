import 'package:cook_helper/additional_classes/color_palette.dart';
import 'package:cook_helper/authentication/login_screen.dart';
import 'package:cook_helper/authentication/user.dart';
import 'package:cook_helper/recipes_work/getRecipes.dart';
import 'package:cook_helper/screens/user_screen.dart';
import 'package:cook_helper/widgets/small_recipe.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  bool recipeUploaded = false;
  late var currentUser;
  Future<void> recipeGetter() async {
    AuthService authService = AuthService();
    await authService.signInAnon();
    recipesList = await recipeDatabaseWork.getRecipes();
    setState(() {
      recipeUploaded = true;
    });
  }

  @override
  void initState() {
    recipeGetter();
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
    print("Current user: ${currentUser.toString()}");
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
      body: Visibility(
        visible: recipeUploaded,
        replacement: Align(
          alignment: Alignment.center,
          child: LoadingAnimationWidget.flickr(
            leftDotColor: const Color(0xFF0063DC),
            rightDotColor: const Color(0xFFFF0084),
            size: 70,
          ),
        ),
        child: SafeArea(
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
                  recipeUploaded
                      ? Dismissible(
                          resizeDuration: const Duration(milliseconds: 10),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              if (currentIndex + 1 < recipesList.length &&
                                  (currentIndex - 1 >= 0)) {
                                currentIndex +=
                                    direction == DismissDirection.endToStart
                                        ? 1
                                        : -1;
                              } else if (currentIndex == 0) {
                                direction == DismissDirection.endToStart
                                    ? currentIndex += 1
                                    : currentIndex += recipesList.length - 1;
                              } else if (currentIndex ==
                                  recipesList.length - 1) {
                                direction == DismissDirection.endToStart
                                    ? currentIndex += -recipesList.length + 1
                                    : currentIndex -= 1;
                              }
                            });
                          },
                          key: ValueKey(currentIndex),
                          child: SmallRecipe(
                            recipe: recipesList.elementAt(currentIndex)
                          ),
                        )
                      : const SizedBox(),
                  Container(
                    color: colorPalette.lightOrange,
                    width: 10.w,
                    height: 60.h,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
