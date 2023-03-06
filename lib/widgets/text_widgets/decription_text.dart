import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),

    );
  }
}
