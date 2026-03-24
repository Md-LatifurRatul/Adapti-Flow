import 'package:flutter/material.dart';

/// A safe layout wrapper that handles common overflow and safe area concerns.
///
/// Wraps content in [SafeArea] + optional [SingleChildScrollView] with
/// keyboard-aware bottom padding. Works on all device types.
///
/// **Handles:**
/// - Device notches and status bars ([SafeArea])
/// - Content overflow ([SingleChildScrollView])
/// - Keyboard overlay (bottom padding from [viewInsets])
/// - Optional max width/height constraints
///
/// ```dart
/// SafeResponsiveLayout(
///   padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
///   child: Column(children: [...]),
/// )
/// ```
class SafeResponsiveLayout extends StatelessWidget {
  /// The child widget to wrap.
  final Widget child;

  /// Optional padding around the child.
  final EdgeInsets? padding;

  /// Whether to maintain bottom view padding in [SafeArea] (default: true).
  final bool maintainBottomViewPadding;

  /// Whether to wrap content in a [SingleChildScrollView] (default: true).
  final bool enableScroll;

  /// Optional maximum width constraint. Useful for centering content on
  /// wide screens (e.g., tablets, desktops).
  final double? maxWidth;

  /// Optional maximum height constraint.
  final double? maxHeight;

  /// Optional scroll physics for the [SingleChildScrollView].
  final ScrollPhysics? physics;

  const SafeResponsiveLayout({
    super.key,
    required this.child,
    this.padding,
    this.maintainBottomViewPadding = true,
    this.enableScroll = true,
    this.maxWidth,
    this.maxHeight,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = child;

    // Apply padding if provided
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    // Apply max width/height constraints if provided
    if (maxWidth != null || maxHeight != null) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? double.infinity,
            maxHeight: maxHeight ?? double.infinity,
          ),
          child: content,
        ),
      );
    }

    // Wrap in scroll view if enabled
    if (enableScroll) {
      content = SingleChildScrollView(
        physics: physics,
        // Protect against keyboard overflow
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: content,
      );
    }

    // Wrap in SafeArea to handle notches/status bars
    return SafeArea(
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: content,
    );
  }
}

/// Backward-compatible alias for [SafeResponsiveLayout].
@Deprecated('Use SafeResponsiveLayout instead')
typedef SafeMobileLayout = SafeResponsiveLayout;
