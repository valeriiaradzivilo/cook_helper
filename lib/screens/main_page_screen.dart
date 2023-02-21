import 'package:cook_helper/widgets/small_recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color backColor = Color(0xFF9FB4E7);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: Text("Cookbook Helper"),
        centerTitle: true,
        backgroundColor: backColor,
        elevation: 0.2,
        actions: [
          IconButton(onPressed: () {},
              icon: const Icon(Icons.person_outline))
        ],
      ),
      body: SafeArea(
        child:
            Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10.w,
                    height: 60.h,
                    color: Color(0xFFD0AB9C),
                  ),
                  SmallRecipe(),
                  Container(
                    width: 10.w,
                    height: 60.h,
                    color: Color(0xFFD0AB9C),
                  ),
                ],
              ),
            ),


      ),
    );
  }
}
