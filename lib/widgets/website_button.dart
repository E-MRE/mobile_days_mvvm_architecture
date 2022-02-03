import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebSiteButton extends StatelessWidget {
  const WebSiteButton({
    Key? key,
    required this.website,
    this.text,
    this.textStyle,
    this.buttonStyle,
    this.background = const Color.fromRGBO(30, 188, 253, 1),
    this.radius = 16,
  }) : super(key: key);

  final String website;
  final String? text;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  final Color background;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async => _openUrl(website: website),
      child: Text(text ?? 'Web Sitesine Git'),
      style: buttonStyle ??
          ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(double.infinity),
              primary: background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              )),
    );
  }

  Future<void> _openUrl(
      {VoidCallback? errorCallback, required String website}) async {
    if (await canLaunch(website)) {
      await launch(website);
    } else {
      errorCallback?.call();
    }
  }
}
