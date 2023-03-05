import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  const SmallText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
    );
  }
}
