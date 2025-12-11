/// Defines the screen width breakpoints for adaptive UI changes.
class Breakpoints {
  Breakpoints._(); // Private constructor to prevent instantiation

  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double widescreen = 1920;

  /// Get breakpoint name for current width
  static String getBreakpointName(double width) {
    if (width >= widescreen) return 'widescreen';
    if (width >= desktop) return 'desktop';
    if (width >= tablet) return 'tablet';
    if (width >= mobile) return 'large-mobile';
    return 'mobile';
  }
}
