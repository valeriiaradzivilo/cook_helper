import 'package:cook_helper/recipes_work/getRecipes.dart';
import 'package:cook_helper/widgets/small_recipe.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../authentication/auth.dart';
import '../recipes_work/recipe.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  Color backColor = const Color(0xFF9FB4E7);
  List<Recipe> recipesList = [];
  RecipesList recipeDatabaseWork = RecipesList();
  bool recipeUploaded = false;
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
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: const Text("Cookbook Helper"),
        centerTitle: true,
        backgroundColor: backColor,
        elevation: 0.2,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline))
        ],
      ),
      body: Visibility(
        visible: recipeUploaded,
        replacement: const Align(
            alignment: Alignment.center, child: CircularProgressIndicator()),
        child: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10.w,
                  height: 60.h,
                  color: const Color(0xFFD0AB9C),
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
                            } else if (currentIndex == recipesList.length - 1) {
                              direction == DismissDirection.endToStart
                                  ? currentIndex += -recipesList.length + 1
                                  : currentIndex -= 1;
                            }
                          });
                        },
                        key: ValueKey(currentIndex),
                        child: SmallRecipe(
                          recipe: recipesList.elementAt(currentIndex),
                        ))
                    : const SizedBox(),
                Container(
                  width: 10.w,
                  height: 60.h,
                  color: const Color(0xFFD0AB9C),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
