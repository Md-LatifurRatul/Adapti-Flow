import 'package:flutter/material.dart';
import 'package:adapti_flow/core/responsive/adapti_flow_config.dart';
import 'package:adapti_flow/core/responsive/device_type.dart';

/// A widget that switches between layouts based on available width constraints.
///
/// Uses [LayoutBuilder] internally, which means it responds to the **parent's
/// constraints** — not the full screen width. This is the correct behavior
/// when the widget may be embedded inside constrained containers (sidebars,
/// dialogs, split views).
///
/// For decisions based on **actual screen width** (e.g., font sizing, adaptive
/// values), use `context.isMobile`, `context.isTablet`, etc. from the
/// [ResponsiveDimensions] extension, which uses [MediaQuery].
///
/// Breakpoints are driven by [AdaptiFlowData] configuration. Falls back to
/// defaults when no [AdaptiFlow] ancestor is found.
///
/// ```dart
/// ResponsiveLayout(
///   mobile: MobileHomePage(),
///   tablet: TabletHomePage(),
///   desktop: DesktopHomePage(),
///   widescreen: WidescreenHomePage(), // Optional
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  /// The widget to display on mobile-sized constraints (required).
  final Widget mobile;

  /// The widget to display on tablet-sized constraints.
  /// Falls back to [mobile] if null.
  final Widget? tablet;

  /// The widget to display on desktop-sized constraints.
  /// Falls back to [tablet] ?? [mobile] if null.
  final Widget? desktop;

  /// The widget to display on widescreen-sized constraints.
  /// Falls back to [desktop] ?? [tablet] ?? [mobile] if null.
  final Widget? widescreen;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.widescreen,
  });

  @override
  Widget build(BuildContext context) {
    final config = AdaptiFlow.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= config.widescreenBreakpoint) {
          return widescreen ?? desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= config.desktopBreakpoint) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= config.mobileBreakpoint) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// A responsive builder that provides [DeviceType] along with [BoxConstraints].
///
/// Like [ResponsiveLayout], this uses [LayoutBuilder] and responds to parent
/// constraints. The [DeviceType] is resolved from constraint width using
/// config-driven breakpoints.
///
/// ```dart
/// ResponsiveLayoutBuilder(
///   builder: (context, constraints, deviceType) {
///     return switch (deviceType) {
///       DeviceType.mobile => MobileView(),
///       DeviceType.tablet => TabletView(),
///       _ => DesktopView(),
///     };
///   },
/// )
/// ```
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// Builder that receives the current [BuildContext], [BoxConstraints],
  /// and resolved [DeviceType] based on constraint width.
  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    DeviceType deviceType,
  ) builder;

  const ResponsiveLayoutBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final config = AdaptiFlow.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final type = resolveDeviceType(
          constraints.maxWidth,
          mobileBreakpoint: config.mobileBreakpoint,
          desktopBreakpoint: config.desktopBreakpoint,
          widescreenBreakpoint: config.widescreenBreakpoint,
        );
        return builder(context, constraints, type);
      },
    );
  }
}