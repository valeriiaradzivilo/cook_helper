import 'dart:typed_data';

import 'package:cook_helper/widgets/text_widgets/SmallText.dart';
import 'package:cook_helper/widgets/text_widgets/decription_text.dart';
import 'package:cook_helper/widgets/text_widgets/main_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../additional_classes/color_palette.dart';
import '../recipes_work/recipe.dart';
import '../screens/open_recipe_screen.dart';

class FavouriteRecipe extends StatefulWidget {
  const FavouriteRecipe({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;
  @override
  State<FavouriteRecipe> createState() => _FavouriteRecipeState();
}

class _FavouriteRecipeState extends State<FavouriteRecipe> {
  ColorPalette colorPalette = ColorPalette();

  Uint8List? targetlUinit8List;
  late Uint8List originalUnit8List;
  @override
  void initState() {
    targetlUinit8List = widget.recipe.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 70.h,
          width: 70.w,
          color: colorPalette.lightWhite,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                 child: SizedBox(
                   width: 30.w,
                     child: Image.memory(targetlUinit8List!))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      widget.recipe.name.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 20,
                      ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    ),

                  ),
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
                      style: TextStyle(fontSize: 5.w),
                    ),
                  ),
                ],
              ),
            ]),
          )),
    );
  }
}
