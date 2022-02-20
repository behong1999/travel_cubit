import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:marquee/marquee.dart';

class AppLargeText extends StatelessWidget {
  AppLargeText({
    Key? key,
    required this.text,
    this.maxLines,
    this.size = 30,
    this.bold = true,
    this.color = Colors.black,
  }) : super(key: key);

  double size;
  final String text;
  Color color;
  bool bold;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      minFontSize: size,
      maxLines: maxLines,
      overflowReplacement: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 30,
        child: Marquee(
          blankSpace: 140,
          scrollAxis: Axis.horizontal,
          velocity: 20,
          text: text,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
