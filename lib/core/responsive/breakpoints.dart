import 'package:responsive_ui/core/responsive/device_type.dart';

/// Defines the default screen width breakpoints for adaptive UI changes.
///
/// These static constants serve as compile-time defaults. For runtime
/// customization, use [AdaptiFlow] with [AdaptiFlowData] instead.
class Breakpoints {
  Breakpoints._(); // Private constructor to prevent instantiation

  /// Width below which the device is considered mobile (default: 600px)
  static const double mobile = 600;

  /// Intermediate tablet breakpoint (default: 900px).
  /// Used by [adaptiveConstrained] for tablet max width.
  static const double tablet = 900;

  /// Width at which the device transitions to desktop (default: 1200px)
  static const double desktop = 1200;

  /// Width at which the device is considered widescreen (default: 1920px)
  static const double widescreen = 1920;

  /// Get breakpoint name for current width.
  ///
  /// Prefer using [DeviceType] enum via `context.deviceType` or
  /// `resolveDeviceType()` for type-safe device detection.
  @Deprecated('Use resolveDeviceType() or context.deviceType instead')
  static String getBreakpointName(double width) {
    return resolveDeviceType(width).name;
  }
}
