// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/counter_dzikir.png
  AssetGenImage get counterDzikir =>
      const AssetGenImage('assets/images/counter_dzikir.png');

  /// File path: assets/images/empty_dzikir.png
  AssetGenImage get emptyDzikir =>
      const AssetGenImage('assets/images/empty_dzikir.png');

  /// File path: assets/images/icon_dzikir_small.png
  AssetGenImage get iconDzikirSmall =>
      const AssetGenImage('assets/images/icon_dzikir_small.png');

  /// File path: assets/images/info_setting_color.png
  AssetGenImage get infoSettingColor =>
      const AssetGenImage('assets/images/info_setting_color.png');

  /// File path: assets/images/pagi_icon_color.png
  AssetGenImage get pagiIconColor =>
      const AssetGenImage('assets/images/pagi_icon_color.png');

  /// File path: assets/images/petang_icon_color.png
  AssetGenImage get petangIconColor =>
      const AssetGenImage('assets/images/petang_icon_color.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        counterDzikir,
        emptyDzikir,
        iconDzikirSmall,
        infoSettingColor,
        pagiIconColor,
        petangIconColor
      ];
}

class Assets {
  const Assets._();

  static const String dzikirpagi = 'assets/dzikirpagi.json';
  static const String dzikirpetang = 'assets/dzikirpetang.json';
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const String secretDev = 'assets/secret-dev.json';
  static const String secret = 'assets/secret.json';

  /// List of all assets
  static List<String> get values =>
      [dzikirpagi, dzikirpetang, secretDev, secret];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
