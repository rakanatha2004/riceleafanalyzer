import 'package:flutter/widgets.dart';

/// Simple responsive helper based on screen width.
/// Uses a reference design width of 390 (typical mobile width) and scales
/// values proportionally. Use sparingly for sizes and fonts.
double scaleWidth(
  BuildContext context,
  double value, {
  double baseWidth = 390,
}) {
  final w = MediaQuery.of(context).size.width;
  return value * (w / baseWidth);
}

/// Scale height relative to screen height using a base height (e.g. 844).
double scaleHeight(
  BuildContext context,
  double value, {
  double baseHeight = 844,
}) {
  final h = MediaQuery.of(context).size.height;
  return value * (h / baseHeight);
}

/// Scale text size — by default we scale with width.
double scaleText(BuildContext context, double fontSize) =>
    scaleWidth(context, fontSize);
