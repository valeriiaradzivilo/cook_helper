import 'package:cook_helper/additional_classes/color_palette.dart';
import 'package:cook_helper/screens/open_recipe_screen.dart';
import 'package:cook_helper/widgets/text_widgets/SmallText.dart';
import 'package:cook_helper/widgets/text_widgets/main_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../recipes_work/recipe.dart';

class SmallRecipe extends StatefulWidget {
  const SmallRecipe({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  State<SmallRecipe> createState() => _SmallRecipeState();
}

class _SmallRecipeState extends State<SmallRecipe> {
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 70.h,
      width: 70.w,
      color: colorPalette.lightWhite,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          MainText(text: widget.recipe.name),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30.h,
              child: Image.network(
                widget.recipe.imageUrl,
              ),
            ),
          ),
          SmallText(text: widget.recipe.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, OpenRecipeScreen.routeName,
                      arguments: widget.recipe);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorPalette.lightOrange),
                icon: Icon(Icons.open_in_new),
                label: Text(
                  "Open",
                  style: TextStyle(fontSize: 7.w),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.recipe.isLiked = !widget.recipe.isLiked;
                  });
                },
                iconSize: 40,
                icon: Icon(
                  CupertinoIcons.heart,
                  color: widget.recipe.isLiked ? colorPalette.bordo : null,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
