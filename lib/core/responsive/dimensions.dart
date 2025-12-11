import 'package:flutter/material.dart';
import 'package:responsive_ui/core/responsive/responsive.dart';

/// Extension on BuildContext for responsive dimension calculations
extension ResponsiveDimensions on BuildContext {
  // --- Core Dimensions ---

  /// Get full screen height in logical pixels
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get full screen width in logical pixels
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get safe area height (excluding status bar, notch, bottom bar)
  double get safeHeight {
    final padding = MediaQuery.of(this).padding;
    return screenHeight - padding.top - padding.bottom;
  }

  /// Get safe area width (excluding side notches if any)
  double get safeWidth {
    final padding = MediaQuery.of(this).padding;
    return screenWidth - padding.left - padding.right;
  }

  // --- Percentage-based Sizing ---

  /// Height percentage: hp(20) = 20% of screen height
  double hp(double percent) => screenHeight * (percent / 100);

  /// Width percentage: wp(50) = 50% of screen width
  double wp(double percent) => screenWidth * (percent / 100);

  /// Safe height percentage: shp(20) = 20% of safe area height
  double shp(double percent) => safeHeight * (percent / 100);

  /// Safe width percentage: swp(50) = 50% of safe area width
  double swp(double percent) => safeWidth * (percent / 100);

  // --- Device & Orientation Checks ---

  /// Check if device is in portrait orientation
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  /// Check if device is in landscape orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Check if screen width is in mobile range (< 600)
  bool get isMobile => screenWidth < Breakpoints.mobile;

  /// Check if screen width is in tablet range (600-1200)
  bool get isTablet =>
      screenWidth >= Breakpoints.mobile && screenWidth < Breakpoints.desktop;

  /// Check if screen width is in desktop range (>= 1200)
  bool get isDesktop => screenWidth >= Breakpoints.desktop;

  /// Check if screen width is widescreen (>= 1920)
  bool get isWidescreen => screenWidth >= Breakpoints.widescreen;

  // --- Responsive Scaling ---

  /// Scale value based on screen width (mobile: 1x, tablet: 1.2x, desktop: 1.5x)
  double scale(double value) {
    if (isDesktop) return value * 1.5;
    if (isTablet) return value * 1.2;
    return value;
  }

  /// Scale font size responsively
  double fontSize(double size) {
    if (isDesktop) return size * 1.3;
    if (isTablet) return size * 1.15;
    return size;
  }

  // --- Adaptive Values ---

  /// Get adaptive padding based on screen size
  double get adaptivePadding {
    if (isDesktop) return 32.0;
    if (isTablet) return 24.0;
    return 16.0;
  }

  /// Get adaptive margin based on screen size
  double get adaptiveMargin {
    if (isDesktop) return 24.0;
    if (isTablet) return 16.0;
    return 12.0;
  }

  /// Get adaptive spacing based on screen size
  double get adaptiveSpacing {
    if (isDesktop) return 16.0;
    if (isTablet) return 12.0;
    return 8.0;
  }

  // --- Safe Area Info ---

  /// Get top safe area padding (status bar, notch)
  double get topPadding => MediaQuery.of(this).padding.top;

  /// Get bottom safe area padding (home indicator, navigation bar)
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Get keyboard height (when visible)
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => keyboardHeight > 0;

  // --- Text Scale Factor ---

  /// Get system text scale factor
  double get textScaleFactor => MediaQuery.textScalerOf(this).scale(1);

  /// Calculate actual text size with system scaling
  double textSize(double size) => size * textScaleFactor;
}

// --- Overflow Guard: Constraining Large Widgets ---

/// Extension to prevent content overflow on large screens
extension ResponsiveConstraints on Widget {
  /// Centers the widget and ensures its width does not exceed [maxWidth].
  /// Essential for preventing content stretching on large monitors.
  Widget constrained({double maxWidth = 800}) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: this,
      ),
    );
  }

  /// Constrains widget with both max width and height
  Widget constrainedBoth({double maxWidth = 800, double maxHeight = 600}) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
        child: this,
      ),
    );
  }

  /// Responsive constraint based on screen size
  Widget adaptiveConstrained(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.isDesktop
              ? 1200
              : (context.isTablet ? 900 : double.infinity),
        ),
        child: this,
      ),
    );
  }
}
