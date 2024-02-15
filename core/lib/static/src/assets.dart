import 'package:core/core.dart';

class Assets {
  static const String assets = "assets";
  static final images = _Images();
  static final icons = _Icons();
}

class _Icons {
  static const String icons = "${Assets.assets}/icons";
  final String logo = "$icons/logo.png";
}

class _Images {
  static const String images = "${Assets.assets}/images";
  final String logo = "$images/logo.png";
}
