import 'package:cook_helper/authentication/login_screen.dart';
import 'package:cook_helper/screens/create_recipe_screen.dart';
import 'package:cook_helper/screens/main_page_screen.dart';
import 'package:cook_helper/screens/open_recipe_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'authentication/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'CookHelper',
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      print("completedAppInitialize");
    });

  }
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType)
    {
      return MaterialApp(
          title: 'Cookbook Helper',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
          ),
        routes: {
            '/':(context) => const CreateRecipeScreen(),
            '/openRecipe':(context)=>const OpenRecipeScreen(),
        },
        );
    }
    );
  }
}
