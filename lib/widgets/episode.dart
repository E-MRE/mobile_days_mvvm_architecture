import 'package:flutter/material.dart';

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.text,
    this.textStyle,
    this.height = 28,
    this.width = 154,
    this.background = const Color.fromRGBO(79, 191, 103, 1),
  }) : super(key: key);

  final String text;
  final double width;
  final double? height;
  final Color background;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            text,
            style: textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'DMSans-Medium',
                ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
