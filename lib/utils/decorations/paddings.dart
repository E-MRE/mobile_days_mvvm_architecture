import 'package:flutter/material.dart';

class Paddings extends Padding {
  ///Standart tüm yüzeye `8.0` padding uygular.
  const Paddings({Key? key, Widget? child})
      : super(
          key: key,
          child: child,
          padding: const EdgeInsets.all(8),
        );

  ///Standart tüm yüzeye `24.0` padding uygular.
  const Paddings.page({Key? key, Widget? child})
      : super(key: key, child: child, padding: const EdgeInsets.all(24));

  ///Bottom'a `16` diğer tüm yüzeye `40.0` padding uygular.
  const Paddings.homePage({Key? key, Widget? child})
      : super(
          key: key,
          child: child,
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 16),
        );
}
