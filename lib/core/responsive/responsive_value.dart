import 'package:flutter/material.dart';

import 'dimensions.dart';

/// Returns a specific value based on the current screen size.
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

/// Class-based responsive value for reusability
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

  /// Get value based on current context
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

/// Orientation-aware responsive value
T orientationValue<T>(
  BuildContext context, {
  required T portrait,
  required T landscape,
}) {
  return context.isPortrait ? portrait : landscape;
}
