import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SmallRecipe extends StatefulWidget {
  const SmallRecipe({Key? key}) : super(key: key);

  @override
  State<SmallRecipe> createState() => _SmallRecipeState();
}

class _SmallRecipeState extends State<SmallRecipe> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70.h,
        width: 70.w,
        color: Color(0xFFFEF5EF),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              Text("Name"),
              Placeholder(),
              Text("Description"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(onPressed: () {  },
                    icon: Icon(Icons.open_in_new),
                    label: Text("Open"),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.heart))
                ],
              )
            ]
          ),
      ),
    );
  }
}
