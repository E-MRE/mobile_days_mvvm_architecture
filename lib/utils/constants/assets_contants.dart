class AssetsConstants {
  static AssetsConstants? _instance;
  final _PngAssets _pngAssets;
  final _SvgAssets _svgAssets;

  AssetsConstants._init()
      : _svgAssets = _SvgAssets(),
        _pngAssets = _PngAssets();

  static _PngAssets get png {
    _instance ??= AssetsConstants._init();
    return _instance!._pngAssets;
  }

  static _SvgAssets get svg {
    _instance ??= AssetsConstants._init();
    return _instance!._svgAssets;
  }
}

class _SvgAssets {
  final String search = 'ic_outline_search'.toSvg;
}

class _PngAssets {
  final String marsIcon = 'ic_flutter_mars'.toPng;
}

extension _AssetsConstantsExtension on String {
  String get toSvg => 'assets/images/svg/$this.svg';
  String get toPng => 'assets/images/png/$this.png';
}
