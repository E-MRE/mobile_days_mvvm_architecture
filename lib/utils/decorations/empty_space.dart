import 'package:flutter/cupertino.dart';

class EmptySpace extends SizedBox {
  ///Dikeyden ve yataydan `8.0` boşluk oluşturur.
  ///
  ///  `Diğer araçlar:`
  /// * extraSmallHeigh = 4
  /// * smallHeigh = 8
  /// * normalHeigh = 16
  /// * bigHeigh = 24
  /// * extraSmallWidth = 4
  /// * smallWidth = 8
  /// * normalWidth = 16
  /// * bigWidth = 24
  const EmptySpace({Key? key}) : super(key: key, height: 8, width: 8);

  ///Dikeyden `4.0` boşluk oluşturur.
  const EmptySpace.extraSmallHeigh({Key? key}) : super(key: key, height: 4);

  ///Dikeyden `8.0` boşluk oluşturur.
  const EmptySpace.smallHeigh({Key? key}) : super(key: key, height: 8);

  ///Dikeyden `16.0` boşluk oluşturur.
  const EmptySpace.normalHeigh({Key? key}) : super(key: key, height: 16);

  ///Dikeyden `24.0` boşluk oluşturur.
  const EmptySpace.bigHeigh({Key? key}) : super(key: key, height: 24);

  ///Dikeyden `32.0` boşluk oluşturur.
  const EmptySpace.veryBigHeigh({Key? key}) : super(key: key, height: 32);

  ///Yataydan `4.0` boşluk oluşturur.
  const EmptySpace.extraSmallWidth({Key? key}) : super(key: key, width: 4);

  ///Yataydan `8.0` boşluk oluşturur.
  const EmptySpace.smallWidth({Key? key}) : super(key: key, width: 8);

  ///Yataydan `16.0` boşluk oluşturur.
  const EmptySpace.normalWidth({Key? key}) : super(key: key, width: 16);

  ///Yataydan `24.0` boşluk oluşturur.
  const EmptySpace.bigWidth({Key? key}) : super(key: key, width: 24);
}
