import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';

Widget buildWithWidth(double width, Widget child) {
  return MediaQuery(
    data: MediaQueryData(size: Size(width, 800)),
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('ResponsiveVisibility', () {
    testWidgets('shows child when device type is in visibleOn', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        400, // mobile
        const ResponsiveVisibility(
          visibleOn: {DeviceType.mobile},
          child: Text('visible'),
        ),
      ));
      expect(find.text('visible'), findsOneWidget);
    });

    testWidgets('hides child when device type is not in visibleOn', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        400, // mobile
        const ResponsiveVisibility(
          visibleOn: {DeviceType.desktop},
          child: Text('visible'),
        ),
      ));
      expect(find.text('visible'), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget); // SizedBox.shrink replacement
    });

    testWidgets('shows child when device type is not in hiddenOn', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        800, // tablet
        const ResponsiveVisibility(
          hiddenOn: {DeviceType.mobile},
          child: Text('visible'),
        ),
      ));
      expect(find.text('visible'), findsOneWidget);
    });

    testWidgets('hides child when device type is in hiddenOn', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        400, // mobile
        const ResponsiveVisibility(
          hiddenOn: {DeviceType.mobile},
          child: Text('visible'),
        ),
      ));
      expect(find.text('visible'), findsNothing);
    });

    testWidgets('shows custom replacement when hidden', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        400, // mobile
        const ResponsiveVisibility(
          visibleOn: {DeviceType.desktop},
          replacement: Text('replacement'),
          child: Text('visible'),
        ),
      ));
      expect(find.text('visible'), findsNothing);
      expect(find.text('replacement'), findsOneWidget);
    });
  });

  group('ResponsiveVisibility convenience constructors', () {
    testWidgets('mobileOnly shows on mobile, hides on tablet', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        400,
        const ResponsiveVisibility.mobileOnly(child: Text('mobile')),
      ));
      expect(find.text('mobile'), findsOneWidget);

      await tester.pumpWidget(buildWithWidth(
        800,
        const ResponsiveVisibility.mobileOnly(child: Text('mobile')),
      ));
      expect(find.text('mobile'), findsNothing);
    });

    testWidgets('desktopOnly shows on desktop, hides on mobile', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        1400,
        const ResponsiveVisibility.desktopOnly(child: Text('desktop')),
      ));
      expect(find.text('desktop'), findsOneWidget);

      await tester.pumpWidget(buildWithWidth(
        400,
        const ResponsiveVisibility.desktopOnly(child: Text('desktop')),
      ));
      expect(find.text('desktop'), findsNothing);
    });

    testWidgets('hideOnMobile shows on tablet/desktop, hides on mobile', (tester) async {
      await tester.pumpWidget(buildWithWidth(
        400,
        const ResponsiveVisibility.hideOnMobile(child: Text('content')),
      ));
      expect(find.text('content'), findsNothing);

      await tester.pumpWidget(buildWithWidth(
        800,
        const ResponsiveVisibility.hideOnMobile(child: Text('content')),
      ));
      expect(find.text('content'), findsOneWidget);
    });
  });
}
