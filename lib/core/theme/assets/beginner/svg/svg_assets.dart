import 'package:flutter_svg/flutter_svg.dart';

class SvgAssets {
  /// Returns an `SvgPicture` for a given file path (SVG).
  static SvgPicture getSvg({
    required String filePath,
    double? height,
    double? width,
  }) {
    return SvgPicture.asset(
      filePath,
      height: height,
      width: width,
    );
  }
}
/*leading: SvgAssets.getSvg(
  filePath: 'assets/icons/svg/menu_icon.svg',
  height: 30,
  width: 30,
),
*/
