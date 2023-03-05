import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:cook_helper/additional_classes/color_palette.dart';
import 'package:cook_helper/screens/open_recipe_screen.dart';
import 'package:cook_helper/widgets/text_widgets/SmallText.dart';
import 'package:cook_helper/widgets/text_widgets/main_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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

  Uint8List? targetlUinit8List;
  late Uint8List originalUnit8List;
  @override
  void initState() {
    _resizeImage();
    super.initState();
  }

  void _resizeImage() async {
    String imageUrl = widget.recipe.imageUrl;
    http.Response response = await http.get(Uri.parse(imageUrl));
    originalUnit8List = response.bodyBytes;
    var codec = await ui.instantiateImageCodec(originalUnit8List);
    var frameInfo = await codec.getNextFrame();
    int width = frameInfo.image.width;
    int height = frameInfo.image.height;
    print('Image width: $width, height: $height');
    var codecNew = await ui.instantiateImageCodec(originalUnit8List,
        targetHeight: (40.h).toInt());
    var frameInfoNew = await codecNew.getNextFrame();
    ui.Image targetUiImage = frameInfoNew.image;
    ByteData? targetByteData =
        await targetUiImage.toByteData(format: ui.ImageByteFormat.png);

    setState(() {
      targetlUinit8List = targetByteData!.buffer.asUint8List();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 70.h,
      width: 70.w,
      color: colorPalette.lightWhite,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            height: 10.h,
            child: MainText(
              text: widget.recipe.name,
              sizePercent: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30.h,
              child: targetlUinit8List != null
                  ? Image.memory(targetlUinit8List!)
                  : LoadingAnimationWidget.flickr(
                leftDotColor: const Color(0xFF0063DC),
                rightDotColor: const Color(0xFFFF0084),
                size: 70,
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
