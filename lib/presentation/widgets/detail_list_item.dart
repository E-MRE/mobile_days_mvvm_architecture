import 'package:flutter/material.dart';

class DetailListItem extends StatelessWidget {
  const DetailListItem({Key? key, required this.title, this.value})
      : super(key: key);

  final String title;
  final String? value;

  final Color _titleColor = const Color.fromRGBO(27, 29, 33, 1);
  final Color _valueColor = const Color.fromRGBO(27, 29, 33, 0.4);
  final EdgeInsetsGeometry _padding = const EdgeInsets.symmetric(vertical: 8.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 2),
        Padding(
          padding: _padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: _setStyle(context, _titleColor)),
              Expanded(
                child: Text(
                  value ?? '-',
                  overflow: TextOverflow.ellipsis,
                  style: _setStyle(context, _valueColor, isTitle: false),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle? _setStyle(
    BuildContext context,
    Color color, {
    bool isTitle = true,
  }) {
    return Theme.of(context).textTheme.bodyText1?.copyWith(
        fontFamily: isTitle ? 'DMSans-Bold' : 'DMSans-SemiBold', color: color);
  }
}
