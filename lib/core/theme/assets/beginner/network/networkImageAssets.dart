import 'package:flutter/material.dart';

class NetworkImageAssets {
  /// Returns an `Image` widget for a network image (URL).
  static Image getNetworkImage({
    required String url,
    double? height,
    double? width,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.network(
      url,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
/*leading: NetworkImageAssets.getNetworkImage(
  url: 'https://example.com/image.png',
  height: 40,
  width: 40,
),
*/
