import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class MainText extends StatelessWidget {
  const MainText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 60.w,
        child: Text(
          text,
          style: TextStyle(fontSize: 5.h - (text.length / 3)),
          textAlign: TextAlign.center,
          maxLines: 100,
        ),

    );
  }
}
