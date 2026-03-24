import 'package:flutter/material.dart';
import 'package:adapti_flow/core/responsive/adapti_flow_config.dart';
import 'package:adapti_flow/core/responsive/device_type.dart';

/// Extension on [BuildContext] for responsive dimension calculations.
///
/// All device detection, scaling, and adaptive values are driven by
/// [AdaptiFlowData] configuration. When no [AdaptiFlow] widget is in the
/// tree, sensible defaults are used (matching the original hardcoded values).
///
/// **Performance:** Uses `MediaQuery.sizeOf`, `paddingOf`, `orientationOf`,
/// and `viewInsetsOf` instead of `MediaQuery.of` to minimize unnecessary
/// widget rebuilds.
extension ResponsiveDimensions on BuildContext {
  // --- Configuration Access ---

  /// Get the current [AdaptiFlowData] configuration.
  AdaptiFlowData get _config => AdaptiFlow.of(this);

  // --- Core Dimensions ---

  /// Get full screen height in logical pixels.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Get full screen width in logical pixels.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Get safe area height (excluding status bar, notch, bottom bar).
  double get safeHeight {
    final padding = MediaQuery.paddingOf(this);
    return screenHeight - padding.top - padding.bottom;
  }

  /// Get safe area width (excluding side notches if any).
  double get safeWidth {
    final padding = MediaQuery.paddingOf(this);
    return screenWidth - padding.left - padding.right;
  }

  // --- Percentage-based Sizing ---

  /// Height percentage: `hp(20)` = 20% of screen height.
  double hp(double percent) => screenHeight * (percent / 100);

  /// Width percentage: `wp(50)` = 50% of screen width.
  double wp(double percent) => screenWidth * (percent / 100);

  /// Safe height percentage: `shp(20)` = 20% of safe area height.
  double shp(double percent) => safeHeight * (percent / 100);

  /// Safe width percentage: `swp(50)` = 50% of safe area width.
  double swp(double percent) => safeWidth * (percent / 100);

  // --- Design-Proportional Scaling ---
  //
  // These methods scale values proportionally to a design reference size,
  // similar to flutter_screenutil's `.w`, `.h`, `.r`, `.sp` extensions.
  // Configure the reference size via `AdaptiFlowData.designSize`.

  /// Scale [value] proportionally to design reference width.
  ///
  /// If your design mockup is 375px wide and you set a widget to 100px,
  /// `context.w(100)` will scale it proportionally on any screen width.
  double w(double value) => value * (screenWidth / _config.designSize.width);

  /// Scale [value] proportionally to design reference height.
  double h(double value) => value * (screenHeight / _config.designSize.height);

  /// Scale [value] uniformly using the minimum of width/height ratio.
  ///
  /// Useful for elements that should scale uniformly regardless of
  /// aspect ratio (icons, avatars, border radius).
  double r(double value) {
    final widthRatio = screenWidth / _config.designSize.width;
    final heightRatio = screenHeight / _config.designSize.height;
    return value * (widthRatio < heightRatio ? widthRatio : heightRatio);
  }

  /// Scale font size proportionally to design reference with optional clamp.
  ///
  /// ```dart
  /// Text('Hello', style: TextStyle(fontSize: context.sp(16)))
  /// Text('Hello', style: TextStyle(fontSize: context.sp(16, min: 12, max: 24)))
  /// ```
  double sp(double size, {double? min, double? max}) {
    final scaled = r(size);
    if (min != null && scaled < min) return min;
    if (max != null && scaled > max) return max;
    return scaled;
  }

  // --- Device & Orientation Checks ---

  /// Get the current [DeviceType] based on screen width and config breakpoints.
  DeviceType get deviceType => resolveDeviceType(
        screenWidth,
        mobileBreakpoint: _config.mobileBreakpoint,
        desktopBreakpoint: _config.desktopBreakpoint,
        widescreenBreakpoint: _config.widescreenBreakpoint,
      );

  /// Check if device is in portrait orientation.
  bool get isPortrait =>
      MediaQuery.orientationOf(this) == Orientation.portrait;

  /// Check if device is in landscape orientation.
  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  /// Check if screen width is in mobile range (< mobileBreakpoint).
  bool get isMobile => screenWidth < _config.mobileBreakpoint;

  /// Check if screen width is in tablet range (>= mobileBreakpoint and < desktopBreakpoint).
  bool get isTablet =>
      screenWidth >= _config.mobileBreakpoint &&
      screenWidth < _config.desktopBreakpoint;

  /// Check if screen width is in desktop range (>= desktopBreakpoint).
  bool get isDesktop => screenWidth >= _config.desktopBreakpoint;

  /// Check if screen width is widescreen (>= widescreenBreakpoint).
  bool get isWidescreen => screenWidth >= _config.widescreenBreakpoint;

  // --- Responsive Scaling ---

  /// Scale [value] based on device type.
  ///
  /// Uses configurable scale factors (default: mobile 1x, tablet 1.2x, desktop 1.5x).
  double scale(double value) {
    final config = _config;
    if (isDesktop) return value * config.desktopScaleFactor;
    if (isTablet) return value * config.tabletScaleFactor;
    return value * config.mobileScaleFactor;
  }

  /// Scale font [size] responsively.
  ///
  /// Uses configurable font scale factors (default: mobile 1x, tablet 1.15x, desktop 1.3x).
  /// Intentionally uses smaller multipliers than [scale] to prevent oversized text.
  double fontSize(double size) {
    final config = _config;
    if (isDesktop) return size * config.desktopFontScale;
    if (isTablet) return size * config.tabletFontScale;
    return size * config.mobileFontScale;
  }

  // --- Adaptive Values ---

  /// Get adaptive padding based on device type.
  ///
  /// Default: mobile 16px, tablet 24px, desktop 32px.
  double get adaptivePadding {
    final config = _config;
    if (isDesktop) return config.desktopPadding;
    if (isTablet) return config.tabletPadding;
    return config.mobilePadding;
  }

  /// Get adaptive margin based on device type.
  ///
  /// Default: mobile 12px, tablet 16px, desktop 24px.
  double get adaptiveMargin {
    final config = _config;
    if (isDesktop) return config.desktopMargin;
    if (isTablet) return config.tabletMargin;
    return config.mobileMargin;
  }

  /// Get adaptive spacing based on device type.
  ///
  /// Default: mobile 8px, tablet 12px, desktop 16px.
  double get adaptiveSpacing {
    final config = _config;
    if (isDesktop) return config.desktopSpacing;
    if (isTablet) return config.tabletSpacing;
    return config.mobileSpacing;
  }

  // --- Safe Area Info ---

  /// Get top safe area padding (status bar, notch).
  double get topPadding => MediaQuery.paddingOf(this).top;

  /// Get bottom safe area padding (home indicator, navigation bar).
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  /// Get keyboard height (when visible).
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;

  /// Check if keyboard is visible.
  bool get isKeyboardVisible => keyboardHeight > 0;

  // --- Text Scale Factor ---

  /// Get system text scale factor.
  double get textScaleFactor => MediaQuery.textScalerOf(this).scale(1);

  /// Calculate actual text size with system scaling.
  double textSize(double size) => size * textScaleFactor;
}

// --- Overflow Guard: Constraining Large Widgets ---

/// Extension on [Widget] to prevent content overflow on large screens.
extension ResponsiveConstraints on Widget {
  /// Centers the widget and ensures its width does not exceed [maxWidth].
  ///
  /// Essential for preventing content stretching on large monitors.
  Widget constrained({double maxWidth = 800}) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: this,
      ),
    );
  }

  /// Constrains widget with both max width and height.
  Widget constrainedBoth({double maxWidth = 800, double maxHeight = 600}) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
        child: this,
      ),
    );
  }

  /// Responsive constraint based on device type, using config-driven max widths.
  ///
  /// Default: mobile has no constraint, tablet is capped at [tabletMaxWidth] (900),
  /// desktop is capped at [desktopMaxWidth] (1200).
  Widget adaptiveConstrained(BuildContext context) {
    final config = AdaptiFlow.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.isDesktop
              ? config.desktopMaxWidth
              : (context.isTablet ? config.tabletMaxWidth : double.infinity),
        ),
        child: this,
      ),
    );
  }
}
