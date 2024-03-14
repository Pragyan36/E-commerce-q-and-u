import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String text1;
  final String text2;

  const RichTextWidget({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 14),
        children: [
          TextSpan(text: text1),
          // TextSpan(text: '\n'), // Add a line break between the two texts
          TextSpan(text: text2, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
