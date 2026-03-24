import 'package:flutter/material.dart';
import 'package:responsive_ui/core/responsive/responsive_value.dart';

/// A grid widget that auto-adjusts column count based on device type.
///
/// Eliminates the need to manually call `responsiveValue()` for grid columns.
///
/// ```dart
/// ResponsiveGrid(
///   mobileColumns: 2,
///   tabletColumns: 3,
///   desktopColumns: 4,
///   spacing: 16,
///   children: products.map((p) => ProductCard(product: p)).toList(),
/// )
/// ```
class ResponsiveGrid extends StatelessWidget {
  /// The grid's children.
  final List<Widget> children;

  /// Number of columns on mobile (required).
  final int mobileColumns;

  /// Number of columns on tablet. Falls back to [mobileColumns] if null.
  final int? tabletColumns;

  /// Number of columns on desktop. Falls back to [tabletColumns] ?? [mobileColumns].
  final int? desktopColumns;

  /// Number of columns on widescreen. Falls back to [desktopColumns] chain.
  final int? widescreenColumns;

  /// Horizontal spacing between grid items (default: 8).
  final double spacing;

  /// Vertical spacing between grid items (default: 8).
  final double runSpacing;

  /// Width / height ratio of each grid cell (default: 1.0).
  final double childAspectRatio;

  /// Optional padding around the grid.
  final EdgeInsets? padding;

  /// Whether the grid should shrink-wrap its content (default: false).
  final bool shrinkWrap;

  /// Optional scroll physics.
  final ScrollPhysics? physics;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns,
    this.desktopColumns,
    this.widescreenColumns,
    this.spacing = 8,
    this.runSpacing = 8,
    this.childAspectRatio = 1.0,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final columns = responsiveValue<int>(
      context,
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
      widescreen: widescreenColumns,
    );

    return GridView.count(
      crossAxisCount: columns,
      crossAxisSpacing: spacing,
      mainAxisSpacing: runSpacing,
      childAspectRatio: childAspectRatio,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: children,
    );
  }
}
