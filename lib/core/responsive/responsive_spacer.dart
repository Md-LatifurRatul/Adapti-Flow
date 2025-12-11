import 'package:flutter/material.dart';

/// A flexible spacer that automatically creates a [SizedBox]
/// with width or height based on its parent (Row/Column).
class ResponsiveSpacer extends StatelessWidget {
  /// The size (in logical pixels) for the width or height.
  final double size;

  const ResponsiveSpacer({super.key, this.size = 16.0});

  @override
  Widget build(BuildContext context) {
    // This looks up the nearest parent widget (Row/Column) to determine the axis.
    final flex = context.findAncestorWidgetOfExactType<Flex>();

    if (flex != null) {
      if (flex.direction == Axis.horizontal) {
        return SizedBox(width: size);
      } else {
        return SizedBox(height: size);
      }
    }

    // Default to vertical spacer if no parent Flex is found.
    return SizedBox(height: size);
  }
}

/// Predefined spacer sizes for consistency
class Spacers {
  Spacers._();

  // Vertical spacers
  static const vertical4 = ResponsiveSpacer(size: 4);
  static const vertical8 = ResponsiveSpacer(size: 8);
  static const vertical12 = ResponsiveSpacer(size: 12);
  static const vertical16 = ResponsiveSpacer(size: 16);
  static const vertical24 = ResponsiveSpacer(size: 24);
  static const vertical32 = ResponsiveSpacer(size: 32);
  static const vertical48 = ResponsiveSpacer(size: 48);

  // Horizontal spacers
  static const horizontal4 = ResponsiveSpacer(size: 4);
  static const horizontal8 = ResponsiveSpacer(size: 8);
  static const horizontal12 = ResponsiveSpacer(size: 12);
  static const horizontal16 = ResponsiveSpacer(size: 16);
  static const horizontal24 = ResponsiveSpacer(size: 24);
  static const horizontal32 = ResponsiveSpacer(size: 32);
  static const horizontal48 = ResponsiveSpacer(size: 48);

  // Quick access methods
  static Widget v(double size) => ResponsiveSpacer(size: size);
  static Widget h(double size) => ResponsiveSpacer(size: size);
}
