import 'package:flutter/material.dart';

/// A flexible spacer that automatically creates a [SizedBox]
/// with width or height based on its parent axis (Row/Column).
///
/// Walks the ancestor element tree to find the nearest [Flex] widget
/// ([Row], [Column], or direct [Flex]) and checks its direction,
/// then creates either a `SizedBox(width:)` or `SizedBox(height:)`.
///
/// Defaults to vertical spacing if no [Flex] ancestor is found.
///
/// ```dart
/// Column(children: [
///   Text('Item 1'),
///   const ResponsiveSpacer(),        // 16px vertical (auto-detected)
///   Text('Item 2'),
///   const ResponsiveSpacer(size: 24), // 24px vertical
/// ])
///
/// Row(children: [
///   Icon(Icons.star),
///   const ResponsiveSpacer(),        // 16px horizontal (auto-detected)
///   Text('Rating'),
/// ])
/// ```
class ResponsiveSpacer extends StatelessWidget {
  /// The size (in logical pixels) for the width or height.
  final double size;

  const ResponsiveSpacer({super.key, this.size = 16.0});

  @override
  Widget build(BuildContext context) {
    // Walk ancestor tree to find nearest Flex (Row, Column, or Flex).
    // Uses visitAncestorElements with `is Flex` to reliably match
    // Row/Column which are concrete subtypes of Flex.
    Axis? direction;
    context.visitAncestorElements((element) {
      final widget = element.widget;
      if (widget is Flex) {
        direction = widget.direction;
        return false; // stop walking
      }
      return true; // continue
    });

    if (direction == Axis.horizontal) {
      return SizedBox(width: size);
    }

    // Default to vertical spacer (Column or no Flex parent).
    return SizedBox(height: size);
  }
}

/// Predefined spacer sizes for consistency.
///
/// All spacers auto-detect their direction from the parent [Flex] widget.
/// Use the `s*` constants for clarity, or [Spacers.of] for custom sizes.
///
/// ```dart
/// Column(children: [
///   Widget1(),
///   Spacers.s16,  // 16px vertical (auto-detected from Column)
///   Widget2(),
/// ])
///
/// Row(children: [
///   Widget1(),
///   Spacers.s8,   // 8px horizontal (auto-detected from Row)
///   Widget2(),
/// ])
/// ```
class Spacers {
  Spacers._();

  // --- Canonical spacers (direction auto-detected from parent Flex) ---

  /// 4px spacer (direction auto-detected)
  static const s4 = ResponsiveSpacer(size: 4);

  /// 8px spacer (direction auto-detected)
  static const s8 = ResponsiveSpacer(size: 8);

  /// 12px spacer (direction auto-detected)
  static const s12 = ResponsiveSpacer(size: 12);

  /// 16px spacer (direction auto-detected)
  static const s16 = ResponsiveSpacer(size: 16);

  /// 24px spacer (direction auto-detected)
  static const s24 = ResponsiveSpacer(size: 24);

  /// 32px spacer (direction auto-detected)
  static const s32 = ResponsiveSpacer(size: 32);

  /// 48px spacer (direction auto-detected)
  static const s48 = ResponsiveSpacer(size: 48);

  /// Create a spacer of custom [size] (direction auto-detected).
  static Widget of(double size) => ResponsiveSpacer(size: size);

  // --- Backward-compatible aliases (deprecated) ---
  // These exist because the old API had separate vertical*/horizontal* names,
  // but they are functionally identical since direction is auto-detected.

  @Deprecated('Use Spacers.s4 instead. Direction is auto-detected from parent.')
  static const vertical4 = ResponsiveSpacer(size: 4);
  @Deprecated('Use Spacers.s8 instead. Direction is auto-detected from parent.')
  static const vertical8 = ResponsiveSpacer(size: 8);
  @Deprecated('Use Spacers.s12 instead. Direction is auto-detected from parent.')
  static const vertical12 = ResponsiveSpacer(size: 12);
  @Deprecated('Use Spacers.s16 instead. Direction is auto-detected from parent.')
  static const vertical16 = ResponsiveSpacer(size: 16);
  @Deprecated('Use Spacers.s24 instead. Direction is auto-detected from parent.')
  static const vertical24 = ResponsiveSpacer(size: 24);
  @Deprecated('Use Spacers.s32 instead. Direction is auto-detected from parent.')
  static const vertical32 = ResponsiveSpacer(size: 32);
  @Deprecated('Use Spacers.s48 instead. Direction is auto-detected from parent.')
  static const vertical48 = ResponsiveSpacer(size: 48);

  @Deprecated('Use Spacers.s4 instead. Direction is auto-detected from parent.')
  static const horizontal4 = ResponsiveSpacer(size: 4);
  @Deprecated('Use Spacers.s8 instead. Direction is auto-detected from parent.')
  static const horizontal8 = ResponsiveSpacer(size: 8);
  @Deprecated('Use Spacers.s12 instead. Direction is auto-detected from parent.')
  static const horizontal12 = ResponsiveSpacer(size: 12);
  @Deprecated('Use Spacers.s16 instead. Direction is auto-detected from parent.')
  static const horizontal16 = ResponsiveSpacer(size: 16);
  @Deprecated('Use Spacers.s24 instead. Direction is auto-detected from parent.')
  static const horizontal24 = ResponsiveSpacer(size: 24);
  @Deprecated('Use Spacers.s32 instead. Direction is auto-detected from parent.')
  static const horizontal32 = ResponsiveSpacer(size: 32);
  @Deprecated('Use Spacers.s48 instead. Direction is auto-detected from parent.')
  static const horizontal48 = ResponsiveSpacer(size: 48);

  @Deprecated('Use Spacers.of(size) instead. Direction is auto-detected.')
  static Widget v(double size) => ResponsiveSpacer(size: size);
  @Deprecated('Use Spacers.of(size) instead. Direction is auto-detected.')
  static Widget h(double size) => ResponsiveSpacer(size: size);
}
