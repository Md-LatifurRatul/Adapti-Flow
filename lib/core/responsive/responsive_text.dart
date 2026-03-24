import 'package:flutter/material.dart';
import 'package:adapti_flow/core/responsive/dimensions.dart';

/// A text widget with automatic responsive font sizing.
///
/// Eliminates the need to manually call `context.fontSize()` on every
/// [TextStyle]. Supports both breakpoint-based scaling and design-proportional
/// scaling, with optional min/max font size bounds.
///
/// ```dart
/// // Breakpoint-based scaling (default)
/// ResponsiveText('Hello World', baseFontSize: 16)
///
/// // Design-proportional scaling (like screenutil's .sp)
/// ResponsiveText('Hello World', baseFontSize: 16, useDesignScale: true)
///
/// // With min/max bounds
/// ResponsiveText('Hello World', baseFontSize: 16, minFontSize: 12, maxFontSize: 24)
/// ```
class ResponsiveText extends StatelessWidget {
  /// The text to display.
  final String text;

  /// The base font size at design time. This is the font size you'd use
  /// in your design mockup. It will be scaled based on device type.
  final double baseFontSize;

  /// Minimum font size floor. The computed size will never go below this.
  final double? minFontSize;

  /// Maximum font size ceiling. The computed size will never exceed this.
  final double? maxFontSize;

  /// Additional text styling. The [fontSize] in this style is overridden
  /// by the responsive calculation.
  final TextStyle? style;

  /// Text alignment.
  final TextAlign? textAlign;

  /// Maximum number of lines.
  final int? maxLines;

  /// Text overflow behavior.
  final TextOverflow? overflow;

  /// If true, uses design-proportional scaling via `context.sp()`.
  /// If false (default), uses breakpoint-based scaling via `context.fontSize()`.
  final bool useDesignScale;

  const ResponsiveText(
    this.text, {
    super.key,
    this.baseFontSize = 14,
    this.minFontSize,
    this.maxFontSize,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.useDesignScale = false,
  });

  @override
  Widget build(BuildContext context) {
    double computedSize;

    if (useDesignScale) {
      computedSize = context.sp(baseFontSize, min: minFontSize, max: maxFontSize);
    } else {
      computedSize = context.fontSize(baseFontSize);
      if (minFontSize != null && computedSize < minFontSize!) {
        computedSize = minFontSize!;
      }
      if (maxFontSize != null && computedSize > maxFontSize!) {
        computedSize = maxFontSize!;
      }
    }

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: (style ?? const TextStyle()).copyWith(fontSize: computedSize),
    );
  }
}
