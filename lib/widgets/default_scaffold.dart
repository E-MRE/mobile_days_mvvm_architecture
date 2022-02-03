import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.padding = const EdgeInsets.all(24.0),
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final PreferredSizeWidget? appBar;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBar,
      body: Padding(padding: padding, child: body),
    ));
  }
}
