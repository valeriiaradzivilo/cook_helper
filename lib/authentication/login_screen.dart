import 'package:cook_helper/authentication/user.dart';
import 'package:cook_helper/screens/main_page_screen.dart';
import 'package:cook_helper/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const routeName = '/signIn';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Color backColor = const Color(0xFF9FB4E7);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error_message = '';
  final AuthService _auth = AuthService();
  late var currentUser;
  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)!.settings.arguments!=null)
      {
        setState(() {
          currentUser = ModalRoute.of(context)!.settings.arguments as User_Fire;
        });

      }
    else{
      setState(() {
        currentUser=null;
      });
    }
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        elevation: 0.2,
        centerTitle: true,
        title: const Text("CookBook Helper"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    FormFieldWidget(
                      controller: emailController,
                      labelTextForm: "Email",
                      type: "email",
                    ),
                    const SizedBox(),
                    FormFieldWidget(
                      controller: passwordController,
                      labelTextForm: "Password",
                      type: "password",
                    ),
                    const SizedBox(),
                    Text(
                      error_message,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() == true) {
                            dynamic result =
                                await _auth.signInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text);
                            if (result == null) {
                              setState(() {
                                error_message =
                                    "Could not sign with these credentials \nTry checking spelling";
                              });
                            } else {
                                Navigator.pushNamed(context, MainPage.routeName,
                                    arguments: result);

                            }
                          } else {
                            print("You didn't fill all required fields");
                          }
                        },
                        icon: const Icon(Icons.follow_the_signs_sharp),
                        label: const Text("Sign in"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCB7A80),
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
