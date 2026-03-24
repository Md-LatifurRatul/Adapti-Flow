/// Enumeration of supported device types based on screen width breakpoints.
enum DeviceType {
  /// Screen width < mobileBreakpoint (default: 600px)
  mobile,

  /// Screen width >= mobileBreakpoint and < desktopBreakpoint (default: 600-1200px)
  tablet,

  /// Screen width >= desktopBreakpoint and < widescreenBreakpoint (default: 1200-1920px)
  desktop,

  /// Screen width >= widescreenBreakpoint (default: 1920px)
  widescreen,
}

/// Resolves the [DeviceType] for a given [width] using the provided breakpoint thresholds.
///
/// Uses the same breakpoint logic as [ResponsiveDimensions] extension:
/// - mobile: width < [mobileBreakpoint]
/// - tablet: width >= [mobileBreakpoint] && width < [desktopBreakpoint]
/// - desktop: width >= [desktopBreakpoint] && width < [widescreenBreakpoint]
/// - widescreen: width >= [widescreenBreakpoint]
DeviceType resolveDeviceType(
  double width, {
  double mobileBreakpoint = 600,
  double desktopBreakpoint = 1200,
  double widescreenBreakpoint = 1920,
}) {
  if (width >= widescreenBreakpoint) return DeviceType.widescreen;
  if (width >= desktopBreakpoint) return DeviceType.desktop;
  if (width >= mobileBreakpoint) return DeviceType.tablet;
  return DeviceType.mobile;
}
