import 'package:flutter/material.dart';

/// Immutable configuration data for the AdaptiFlow responsive system.
///
/// All fields have sensible defaults that match the original hardcoded values,
/// so the system works identically with zero configuration. Override any field
/// to customize behavior.
///
/// ```dart
/// AdaptiFlow(
///   data: AdaptiFlowData(
///     mobileBreakpoint: 500,
///     designSize: Size(390, 844),
///   ),
///   child: MaterialApp(...),
/// )
/// ```
class AdaptiFlowData {
  // --- Breakpoint Thresholds ---

  /// Width below which the device is considered mobile (default: 600)
  final double mobileBreakpoint;

  /// Width at which the device transitions to desktop (default: 1200)
  final double desktopBreakpoint;

  /// Width at which the device is considered widescreen (default: 1920)
  final double widescreenBreakpoint;

  // --- Design Reference Size ---

  /// The design reference size for proportional scaling.
  /// Set this to your design mockup dimensions (e.g., iPhone 13 Mini: 375x812).
  /// Used by `context.w()`, `context.h()`, `context.r()`, `context.sp()`.
  final Size designSize;

  // --- Scale Factors ---

  /// General scale multiplier for mobile (default: 1.0)
  final double mobileScaleFactor;

  /// General scale multiplier for tablet (default: 1.2)
  final double tabletScaleFactor;

  /// General scale multiplier for desktop (default: 1.5)
  final double desktopScaleFactor;

  // --- Font Scale Factors ---

  /// Font scale multiplier for mobile (default: 1.0)
  final double mobileFontScale;

  /// Font scale multiplier for tablet (default: 1.15)
  final double tabletFontScale;

  /// Font scale multiplier for desktop (default: 1.3)
  final double desktopFontScale;

  // --- Adaptive Values ---

  /// Adaptive padding for mobile (default: 16.0)
  final double mobilePadding;

  /// Adaptive padding for tablet (default: 24.0)
  final double tabletPadding;

  /// Adaptive padding for desktop (default: 32.0)
  final double desktopPadding;

  /// Adaptive margin for mobile (default: 12.0)
  final double mobileMargin;

  /// Adaptive margin for tablet (default: 16.0)
  final double tabletMargin;

  /// Adaptive margin for desktop (default: 24.0)
  final double desktopMargin;

  /// Adaptive spacing for mobile (default: 8.0)
  final double mobileSpacing;

  /// Adaptive spacing for tablet (default: 12.0)
  final double tabletSpacing;

  /// Adaptive spacing for desktop (default: 16.0)
  final double desktopSpacing;

  // --- Constraint Max Widths ---

  /// Max width constraint for tablet layout (default: 900)
  final double tabletMaxWidth;

  /// Max width constraint for desktop layout (default: 1200)
  final double desktopMaxWidth;

  const AdaptiFlowData({
    this.mobileBreakpoint = 600,
    this.desktopBreakpoint = 1200,
    this.widescreenBreakpoint = 1920,
    this.designSize = const Size(375, 812),
    this.mobileScaleFactor = 1.0,
    this.tabletScaleFactor = 1.2,
    this.desktopScaleFactor = 1.5,
    this.mobileFontScale = 1.0,
    this.tabletFontScale = 1.15,
    this.desktopFontScale = 1.3,
    this.mobilePadding = 16.0,
    this.tabletPadding = 24.0,
    this.desktopPadding = 32.0,
    this.mobileMargin = 12.0,
    this.tabletMargin = 16.0,
    this.desktopMargin = 24.0,
    this.mobileSpacing = 8.0,
    this.tabletSpacing = 12.0,
    this.desktopSpacing = 16.0,
    this.tabletMaxWidth = 900,
    this.desktopMaxWidth = 1200,
  });

  /// Creates a copy with the given fields replaced.
  AdaptiFlowData copyWith({
    double? mobileBreakpoint,
    double? desktopBreakpoint,
    double? widescreenBreakpoint,
    Size? designSize,
    double? mobileScaleFactor,
    double? tabletScaleFactor,
    double? desktopScaleFactor,
    double? mobileFontScale,
    double? tabletFontScale,
    double? desktopFontScale,
    double? mobilePadding,
    double? tabletPadding,
    double? desktopPadding,
    double? mobileMargin,
    double? tabletMargin,
    double? desktopMargin,
    double? mobileSpacing,
    double? tabletSpacing,
    double? desktopSpacing,
    double? tabletMaxWidth,
    double? desktopMaxWidth,
  }) {
    return AdaptiFlowData(
      mobileBreakpoint: mobileBreakpoint ?? this.mobileBreakpoint,
      desktopBreakpoint: desktopBreakpoint ?? this.desktopBreakpoint,
      widescreenBreakpoint: widescreenBreakpoint ?? this.widescreenBreakpoint,
      designSize: designSize ?? this.designSize,
      mobileScaleFactor: mobileScaleFactor ?? this.mobileScaleFactor,
      tabletScaleFactor: tabletScaleFactor ?? this.tabletScaleFactor,
      desktopScaleFactor: desktopScaleFactor ?? this.desktopScaleFactor,
      mobileFontScale: mobileFontScale ?? this.mobileFontScale,
      tabletFontScale: tabletFontScale ?? this.tabletFontScale,
      desktopFontScale: desktopFontScale ?? this.desktopFontScale,
      mobilePadding: mobilePadding ?? this.mobilePadding,
      tabletPadding: tabletPadding ?? this.tabletPadding,
      desktopPadding: desktopPadding ?? this.desktopPadding,
      mobileMargin: mobileMargin ?? this.mobileMargin,
      tabletMargin: tabletMargin ?? this.tabletMargin,
      desktopMargin: desktopMargin ?? this.desktopMargin,
      mobileSpacing: mobileSpacing ?? this.mobileSpacing,
      tabletSpacing: tabletSpacing ?? this.tabletSpacing,
      desktopSpacing: desktopSpacing ?? this.desktopSpacing,
      tabletMaxWidth: tabletMaxWidth ?? this.tabletMaxWidth,
      desktopMaxWidth: desktopMaxWidth ?? this.desktopMaxWidth,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdaptiFlowData &&
          runtimeType == other.runtimeType &&
          mobileBreakpoint == other.mobileBreakpoint &&
          desktopBreakpoint == other.desktopBreakpoint &&
          widescreenBreakpoint == other.widescreenBreakpoint &&
          designSize == other.designSize &&
          mobileScaleFactor == other.mobileScaleFactor &&
          tabletScaleFactor == other.tabletScaleFactor &&
          desktopScaleFactor == other.desktopScaleFactor &&
          mobileFontScale == other.mobileFontScale &&
          tabletFontScale == other.tabletFontScale &&
          desktopFontScale == other.desktopFontScale &&
          mobilePadding == other.mobilePadding &&
          tabletPadding == other.tabletPadding &&
          desktopPadding == other.desktopPadding &&
          mobileMargin == other.mobileMargin &&
          tabletMargin == other.tabletMargin &&
          desktopMargin == other.desktopMargin &&
          mobileSpacing == other.mobileSpacing &&
          tabletSpacing == other.tabletSpacing &&
          desktopSpacing == other.desktopSpacing &&
          tabletMaxWidth == other.tabletMaxWidth &&
          desktopMaxWidth == other.desktopMaxWidth;

  @override
  int get hashCode => Object.hash(
        mobileBreakpoint,
        desktopBreakpoint,
        widescreenBreakpoint,
        designSize,
        mobileScaleFactor,
        tabletScaleFactor,
        desktopScaleFactor,
        mobileFontScale,
        tabletFontScale,
        desktopFontScale,
        mobilePadding,
        tabletPadding,
        desktopPadding,
        mobileMargin,
        tabletMargin,
        desktopMargin,
        mobileSpacing,
        tabletSpacing,
        desktopSpacing,
        Object.hash(tabletMaxWidth, desktopMaxWidth),
      );
}

/// Provides [AdaptiFlowData] configuration to the widget tree.
///
/// Wrap your [MaterialApp] (or any ancestor widget) with [AdaptiFlow] to
/// customize responsive behavior. If omitted, all responsive utilities
/// fall back to sensible defaults — zero configuration required.
///
/// ```dart
/// AdaptiFlow(
///   data: AdaptiFlowData(
///     mobileBreakpoint: 500,
///     desktopBreakpoint: 1024,
///     designSize: Size(390, 844),
///   ),
///   child: MaterialApp(...),
/// )
/// ```
class AdaptiFlow extends InheritedWidget {
  /// The responsive configuration data.
  final AdaptiFlowData data;

  const AdaptiFlow({
    super.key,
    required this.data,
    required super.child,
  });

  /// Retrieves the nearest [AdaptiFlowData] from the widget tree.
  ///
  /// Returns [const AdaptiFlowData()] (all defaults) if no [AdaptiFlow]
  /// ancestor is found. This ensures backward compatibility — the system
  /// works identically with or without an [AdaptiFlow] wrapper.
  ///
  /// This creates a dependency: the calling widget rebuilds when config changes.
  static AdaptiFlowData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AdaptiFlow>();
    return widget?.data ?? const AdaptiFlowData();
  }

  /// Retrieves the nearest [AdaptiFlowData] without creating a dependency.
  ///
  /// Use this for one-time reads where you don't need to rebuild when
  /// config changes (e.g., during initialization).
  static AdaptiFlowData maybeOf(BuildContext context) {
    final widget = context.getInheritedWidgetOfExactType<AdaptiFlow>();
    return widget?.data ?? const AdaptiFlowData();
  }

  @override
  bool updateShouldNotify(AdaptiFlow oldWidget) => data != oldWidget.data;
}
