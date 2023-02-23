import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          maxLines: 500,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
