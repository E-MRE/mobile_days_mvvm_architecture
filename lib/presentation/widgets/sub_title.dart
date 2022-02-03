import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key? key,
    required this.text,
    this.textStyle,
    this.fontSize = 36,
    this.align = TextAlign.center,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;
  final double fontSize;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        textAlign: align,
        overflow: TextOverflow.ellipsis,
        style: textStyle ??
            Theme.of(context).textTheme.headline4?.copyWith(
                  fontFamily: 'DMSans-Bold',
                  letterSpacing: -1.6,
                  fontSize: fontSize,
                  color: const Color.fromRGBO(27, 29, 33, 1),
                ),
      ),
    );
  }
}
