import 'package:flutter/material.dart';

/// A safe mobile layout wrapper that handles:
/// - Device notches/status bars (SafeArea)
/// - Content overflow (SingleChildScrollView)
/// - Keyboard overflow (viewInsets)
class SafeMobileLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool maintainBottomViewPadding;
  final bool enableScroll;

  const SafeMobileLayout({
    super.key,
    required this.child,
    this.padding,
    this.maintainBottomViewPadding = true,
    this.enableScroll = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = child;

    // Add default padding if not provided
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    // Wrap in scroll view if enabled
    if (enableScroll) {
      content = SingleChildScrollView(
        // Protect against keyboard overflow
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
