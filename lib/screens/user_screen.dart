import 'package:cook_helper/authentication/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  static const routeName = '/selectUser';

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User_Fire;
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser.username!),
      ),
    );
  }
}
