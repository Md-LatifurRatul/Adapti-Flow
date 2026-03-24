import 'package:flutter/material.dart';

import 'package:adapti_flow/core/responsive/dimensions.dart';

/// Returns a value based on the current device type (screen width).
///
/// Uses [ResponsiveDimensions] extension which reads breakpoints from
/// [AdaptiFlowData] configuration.
///
/// ```dart
/// final columns = responsiveValue(
///   context,
///   mobile: 1,
///   tablet: 2,
///   desktop: 3,
///   widescreen: 4,
/// );
/// ```
T responsiveValue<T>(
  BuildContext context, {
  required T mobile,
  T? tablet,
  T? desktop,
  T? widescreen,
}) {
  if (context.isWidescreen) return widescreen ?? desktop ?? tablet ?? mobile;
  if (context.isDesktop) return desktop ?? tablet ?? mobile;
  if (context.isTablet) return tablet ?? mobile;
  return mobile;
}

/// A reusable class-based responsive value.
///
/// Useful when the same responsive value is needed in multiple places.
///
/// ```dart
/// final gridColumns = ResponsiveValue<int>(
///   mobile: 2,
///   tablet: 3,
///   desktop: 4,
/// );
///
/// // Use anywhere:
/// GridView.count(crossAxisCount: gridColumns.of(context))
/// ```
class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;
  final T? widescreen;

  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.widescreen,
  });

  /// Get value based on current context. Shorthand for [getValue].
  T of(BuildContext context) => getValue(context);

  /// Get value based on current context.
  T getValue(BuildContext context) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      widescreen: widescreen,
    );
  }
}

/// Returns a value based on the current device orientation.
///
/// ```dart
/// final padding = orientationValue(
///   context,
///   portrait: 16.0,
///   landscape: 24.0,
/// );
/// ```
T orientationValue<T>(
  BuildContext context, {
  required T portrait,
  required T landscape,
}) {
  return context.isPortrait ? portrait : landscape;
}
