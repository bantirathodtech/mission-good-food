import 'package:flutter/material.dart';

/// A reusable custom ImageButton widget for consistent design across apps.
///
/// Features:
/// - Customizable button size using [height] and [width].
/// - Load images from assets ([imagePath]) or use custom widgets ([imageWidget]).
//// - Optionally set minimum button size using [minHeight], [minWidth] (optional).
/// - Customize padding around the image using [padding].
/// - Handle actions via [onPressed].
///
/// Example Usage:
/// ```dart
/// CustomImageButton(
///   imagePath: 'assets/images/back_arrow.png',
///   height: 30,
///   width: 30,
///   onPressed: () => Navigator.pop(context),
/// )
/// ```

/// A reusable custom ImageButton widget for consistent design across apps.
/// - Supports Asset Images (PNG, JPG), Network Images, and SVG Images.
/// - Customize image size, button size, and padding.
class CustomImageButton extends StatelessWidget {
  final String? imagePath; // For Asset Images (PNG/JPG)
  final Widget? imageWidget; // For Network or custom widgets (SVG, etc.)
  final double? height; // Image height
  final double? width; // Image width
  final double minHeight;
  final double minWidth;
  final EdgeInsetsGeometry padding;
  final BoxFit fit;
  final VoidCallback onPressed;
  final bool applyConstraints; // Flag to determine whether to apply constraints

  const CustomImageButton({
    super.key,
    this.imagePath,
    this.imageWidget,
    this.height,
    this.width,
    this.minHeight = 48, // Default minimum button height
    this.minWidth = 48, // Default minimum button width
    this.padding = EdgeInsets.zero, // Default no padding
    this.fit = BoxFit.contain,
    required this.onPressed,
    this.applyConstraints = true, // Default to apply constraints
  }) : assert(imagePath != null || imageWidget != null,
            'Either imagePath or imageWidget must be provided.');

  @override
  Widget build(BuildContext context) {
    // Conditionally use the image widget (Network/SVG) or asset image
    final Widget icon = imageWidget ??
        (imagePath != null
            ? Image.asset(
                imagePath!,
                fit: fit,
                height: height,
                width: width,
              )
            : const SizedBox());

    return SizedBox(
      height: height ?? minHeight,
      width: width ?? minWidth,
      child: IconButton(
        padding: padding,
        constraints: applyConstraints
            ? BoxConstraints(
                minHeight: minHeight,
                minWidth: minWidth,
              )
            : null, // Apply constraints conditionally
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}

/*
For Asset Images (PNG/JPG):

leading: CustomImageButton(
  imagePath: 'assets/images/back_arrow.png',
  height: 30, // Image height
  width: 30,  // Image width
  padding: EdgeInsets.all(8), // Optional padding
  minHeight: 30, // Minimum button height
  minWidth: 30,  // Minimum button width
  applyConstraints: true, // Optionally set to false to avoid constraints
  onPressed: () => Navigator.pop(context),
),

For Network Images:
leading: CustomImageButton(
  imageWidget: Image.network(
    'https://example.com/image.png',
    fit: BoxFit.cover,
  ),
  height: 40, // Image height
  width: 40,  // Image width
  padding: EdgeInsets.symmetric(horizontal: 4), // Optional padding
  minHeight: 40, // Minimum button height
  minWidth: 40,  // Minimum button width
  applyConstraints: true, // Optionally set to false to avoid constraints
  onPressed: () => Navigator.pop(context),
),

For SVG Images:
dart
Copy code
leading: CustomImageButton(
  imageWidget: SvgPicture.asset(
    'assets/icons/svg/menu_icon.svg',
    height: 30,
    width: 30,
  ),
  height: 30, // Image height (if needed)
  width: 30,  // Image width (if needed)
  applyConstraints: true, // Optionally set to false to avoid constraints
  onPressed: () => Navigator.pop(context),
),
*/
