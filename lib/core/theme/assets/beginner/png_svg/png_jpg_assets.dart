import 'package:flutter/material.dart';

class PngJpgAssets {
  /// Returns an `Image` widget for a given file path (PNG/JPG).
  static Image getImage({
    required String filePath,
    double? height,
    double? width,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(
      filePath,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
/*leading: PngJpgAssets.getImage(
  filePath: 'assets/images/back_arrow.png',
  height: 30,
  width: 30,
),
*/
