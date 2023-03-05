import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class MainText extends StatelessWidget {
  const MainText({Key? key, required this.text, required this.sizePercent}) : super(key: key);
  final String text;
  final int sizePercent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: sizePercent.w,
        child: Text(
          text,
          style: TextStyle(fontSize: 5.h - (text.length / 3)),
          textAlign: TextAlign.center,
          maxLines: 100,
        ),

    );
  }
}
