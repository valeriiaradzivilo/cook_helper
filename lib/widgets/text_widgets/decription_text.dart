import 'package:flutter/cupertino.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),

    );
  }
}
