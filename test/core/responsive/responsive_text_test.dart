import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';

Widget buildWithWidth(double width, Widget child, {double height = 800}) {
  return MediaQuery(
    data: MediaQueryData(size: Size(width, height)),
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('ResponsiveText', () {
    testWidgets('renders text with responsive font size on mobile', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        400, // mobile
        const ResponsiveText('Hello', baseFontSize: 16),
      ));
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.data, 'Hello');
      expect(text.style?.fontSize, 16.0); // mobile: 1x
    });

    testWidgets('scales font size on tablet', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        800, // tablet
        const ResponsiveText('Hello', baseFontSize: 16),
      ));
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 16 * 1.15); // tablet font scale
    });

    testWidgets('scales font size on desktop', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        1400, // desktop
        const ResponsiveText('Hello', baseFontSize: 16),
      ));
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 16 * 1.3); // desktop font scale
    });

    testWidgets('respects minFontSize', (tester) async {
      // On mobile, fontSize(8) = 8. With min 12, should be 12.
      await tester.pumpWidget(buildWithWidth(
        400,
        const ResponsiveText('Hello', baseFontSize: 8, minFontSize: 12),
      ));
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 12.0);
    });

    testWidgets('respects maxFontSize', (tester) async {
      // On desktop, fontSize(20) = 26. With max 24, should be 24.
      await tester.pumpWidget(buildWithWidth(
        1400,
        const ResponsiveText('Hello', baseFontSize: 20, maxFontSize: 24),
      ));
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 24.0);
    });

    testWidgets('applies additional TextStyle', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        400,
        const ResponsiveText(
          'Hello',
          baseFontSize: 16,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ));
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontWeight, FontWeight.bold);
      expect(text.style?.color, Colors.red);
      expect(text.style?.fontSize, 16.0);
    });

    testWidgets('passes maxLines and overflow', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        400,
        const ResponsiveText(
          'Hello',
          baseFontSize: 14,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ));
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.maxLines, 2);
      expect(text.overflow, TextOverflow.ellipsis);
    });

    testWidgets('useDesignScale uses sp() instead of fontSize()', (tester) async {
      // At width=750, height=800: r(16) = 16 * min(750/375, 800/812)
      // = 16 * min(2.0, 0.985...) = 16 * 0.985... ≈ 15.76
      await tester.pumpWidget(buildWithWidth(
        750,
        const ResponsiveText('Hello', baseFontSize: 16, useDesignScale: true),
        height: 800,
      ));
      final text = tester.widget<Text>(find.byType(Text));
      const expectedSize = 16 * (800 / 812); // min ratio is height
      expect(text.style!.fontSize!, closeTo(expectedSize, 0.01));
    });
  });
}
