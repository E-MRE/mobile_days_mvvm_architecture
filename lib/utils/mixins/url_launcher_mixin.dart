//https://pub.dev/packages/url_launcher

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin UrlLauncherMixin {
  Future<void> openUrl(
      {VoidCallback? errorCallback, required String website}) async {
    if (await canLaunch(website)) {
      await launch(website);
    } else {
      errorCallback?.call();
    }
  }
}
