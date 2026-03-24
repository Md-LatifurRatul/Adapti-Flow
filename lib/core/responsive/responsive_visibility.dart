import 'package:flutter/material.dart';
import 'package:adapti_flow/core/responsive/device_type.dart';
import 'package:adapti_flow/core/responsive/dimensions.dart';

/// A widget that conditionally shows or hides its child based on [DeviceType].
///
/// Uses [MediaQuery] (screen width) for device detection by default.
/// When hidden, shows [replacement] (defaults to [SizedBox.shrink]).
///
/// ```dart
/// // Only visible on mobile and tablet
/// ResponsiveVisibility(
///   visibleOn: {DeviceType.mobile, DeviceType.tablet},
///   child: MobileNavBar(),
/// )
///
/// // Hidden on mobile
/// ResponsiveVisibility(
///   hiddenOn: {DeviceType.mobile},
///   child: SidePanel(),
/// )
/// ```
class ResponsiveVisibility extends StatelessWidget {
  /// The child widget to conditionally display.
  final Widget child;

  /// Widget to show when [child] is hidden (default: [SizedBox.shrink]).
  final Widget replacement;

  /// Set of device types on which [child] is visible.
  /// If null, [hiddenOn] is used instead.
  final Set<DeviceType>? visibleOn;

  /// Set of device types on which [child] is hidden.
  /// Only used when [visibleOn] is null.
  final Set<DeviceType>? hiddenOn;

  const ResponsiveVisibility({
    super.key,
    required this.child,
    this.replacement = const SizedBox.shrink(),
    this.visibleOn,
    this.hiddenOn,
  }) : assert(
          visibleOn != null || hiddenOn != null,
          'Either visibleOn or hiddenOn must be provided',
        );

  /// Show only on mobile devices.
  const ResponsiveVisibility.mobileOnly({
    super.key,
    required this.child,
    this.replacement = const SizedBox.shrink(),
  })  : visibleOn = const {DeviceType.mobile},
        hiddenOn = null;

  /// Show only on tablet devices.
  const ResponsiveVisibility.tabletOnly({
    super.key,
    required this.child,
    this.replacement = const SizedBox.shrink(),
  })  : visibleOn = const {DeviceType.tablet},
        hiddenOn = null;

  /// Show only on desktop and widescreen devices.
  const ResponsiveVisibility.desktopOnly({
    super.key,
    required this.child,
    this.replacement = const SizedBox.shrink(),
  })  : visibleOn = const {DeviceType.desktop, DeviceType.widescreen},
        hiddenOn = null;

  /// Hide on mobile devices, show on all others.
  const ResponsiveVisibility.hideOnMobile({
    super.key,
    required this.child,
    this.replacement = const SizedBox.shrink(),
  })  : hiddenOn = const {DeviceType.mobile},
        visibleOn = null;

  /// Hide on desktop and widescreen, show on mobile and tablet.
  const ResponsiveVisibility.hideOnDesktop({
    super.key,
    required this.child,
    this.replacement = const SizedBox.shrink(),
  })  : hiddenOn = const {DeviceType.desktop, DeviceType.widescreen},
        visibleOn = null;

  @override
  Widget build(BuildContext context) {
    final current = context.deviceType;

    final bool visible;
    if (visibleOn != null) {
      visible = visibleOn!.contains(current);
    } else {
      visible = !hiddenOn!.contains(current);
    }

    return visible ? child : replacement;
  }
}
