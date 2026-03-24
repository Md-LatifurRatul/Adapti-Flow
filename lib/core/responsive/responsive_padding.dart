import 'package:flutter/material.dart';
import 'package:responsive_ui/core/responsive/dimensions.dart';
import 'package:responsive_ui/core/responsive/responsive_value.dart';

/// A widget that applies responsive padding based on device type.
///
/// Eliminates the repetitive `EdgeInsets.all(context.adaptivePadding)` pattern.
///
/// ```dart
/// // Auto-adaptive padding (uses config values)
/// ResponsivePadding.adaptive(
///   child: YourContent(),
/// )
///
/// // Custom per-breakpoint padding
/// ResponsivePadding(
///   mobilePadding: EdgeInsets.all(16),
///   tabletPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
///   desktopPadding: EdgeInsets.symmetric(horizontal: 64, vertical: 32),
///   child: YourContent(),
/// )
/// ```
class ResponsivePadding extends StatelessWidget {
  /// The child widget to wrap with padding.
  final Widget child;

  /// Padding to apply on mobile devices (required for custom mode).
  final EdgeInsets? mobilePadding;

  /// Padding to apply on tablet devices. Falls back to [mobilePadding].
  final EdgeInsets? tabletPadding;

  /// Padding to apply on desktop devices. Falls back to [tabletPadding].
  final EdgeInsets? desktopPadding;

  /// Padding to apply on widescreen devices. Falls back to [desktopPadding].
  final EdgeInsets? widescreenPadding;

  /// If true, uses `context.adaptivePadding` for all-around padding
  /// instead of the per-breakpoint values.
  final bool _useAdaptive;

  /// Custom per-breakpoint padding.
  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.widescreenPadding,
  }) : _useAdaptive = false;

  /// Uses the adaptive padding from [AdaptiFlowData] config on all sides.
  ///
  /// Default: mobile 16px, tablet 24px, desktop 32px.
  const ResponsivePadding.adaptive({
    super.key,
    required this.child,
  })  : mobilePadding = null,
        tabletPadding = null,
        desktopPadding = null,
        widescreenPadding = null,
        _useAdaptive = true;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets resolvedPadding;

    if (_useAdaptive) {
      resolvedPadding = EdgeInsets.all(context.adaptivePadding);
    } else {
      resolvedPadding = responsiveValue<EdgeInsets>(
        context,
        mobile: mobilePadding ?? EdgeInsets.all(context.adaptivePadding),
        tablet: tabletPadding,
        desktop: desktopPadding,
        widescreen: widescreenPadding,
      );
    }

    return Padding(padding: resolvedPadding, child: child);
  }
}
