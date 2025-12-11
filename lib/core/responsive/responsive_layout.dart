import 'package:flutter/material.dart';
import 'package:responsive_ui/core/responsive/responsive.dart';

/// A primary widget for switching between Mobile, Tablet, and Desktop layouts.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Widescreen (>= 1920px)
        if (constraints.maxWidth >= Breakpoints.widescreen) {
          return widescreen ?? desktop ?? tablet ?? mobile;
        }
        // Desktop (>= 1200px)
        else if (constraints.maxWidth >= Breakpoints.desktop) {
          return desktop ?? tablet ?? mobile;
        }
        // Tablet (>= 600px)
        else if (constraints.maxWidth >= Breakpoints.mobile) {
          return tablet ?? mobile;
        }
        // Mobile (< 600px)
        else {
          return mobile;
        }
      },
    );
  }
}

/// Responsive builder that provides current constraints
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints)
  builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: builder);
  }
}
