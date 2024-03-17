import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension MediaQueryExtensions on BuildContext {
  ///MediaQuery DataSized
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ///width and height
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double getFontSize(double size)=> MediaQuery.of(this).size.width * size;

  ///padding
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;
  double get topPadding => MediaQuery.of(this).viewPadding.top;
  double get bottomPadding => MediaQuery.of(this).viewPadding.bottom;
  double get rightPadding => MediaQuery.of(this).viewPadding.right;
  double get leftPadding => MediaQuery.of(this).viewPadding.left;

  ///aspect ratio
  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;

  ///Orientation
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  Orientation get orientation => MediaQuery.of(this).orientation;

  ///app localization
  AppLocalizations get tr => AppLocalizations.of(this)!;
}
