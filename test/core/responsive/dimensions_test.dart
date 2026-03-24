import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';

/// Helper to build a test widget with a specific screen size.
Widget buildTestWidget({
  required double width,
  required double height,
  required Widget child,
  AdaptiFlowData? config,
  EdgeInsets padding = EdgeInsets.zero,
}) {
  Widget app = MediaQuery(
    data: MediaQueryData(size: Size(width, height), padding: padding),
    child: MaterialApp(home: Scaffold(body: child)),
  );
  if (config != null) {
    app = AdaptiFlow(data: config, child: app);
  }
  return app;
}

void main() {
  group('ResponsiveDimensions - Core Dimensions', () {
    testWidgets('screenWidth and screenHeight return correct values', (tester) async {
      late double w, h;
      await tester.pumpWidget(buildTestWidget(
        width: 400,
        height: 800,
        child: Builder(builder: (context) {
          w = context.screenWidth;
          h = context.screenHeight;
          return const SizedBox();
        }),
      ));
      expect(w, 400);
      expect(h, 800);
    });

    testWidgets('safeHeight and safeWidth exclude padding', (tester) async {
      late double sw, sh;
      await tester.pumpWidget(buildTestWidget(
        width: 400,
        height: 800,
        padding: const EdgeInsets.only(top: 44, bottom: 34, left: 0, right: 0),
        child: Builder(builder: (context) {
          sw = context.safeWidth;
          sh = context.safeHeight;
          return const SizedBox();
        }),
      ));
      expect(sh, 800 - 44 - 34);
      expect(sw, 400);
    });
  });

  group('ResponsiveDimensions - Percentage Sizing', () {
    testWidgets('wp and hp calculate correct percentages', (tester) async {
      late double wpResult, hpResult;
      await tester.pumpWidget(buildTestWidget(
        width: 400,
        height: 800,
        child: Builder(builder: (context) {
          wpResult = context.wp(50);
          hpResult = context.hp(25);
          return const SizedBox();
        }),
      ));
      expect(wpResult, 200); // 50% of 400
      expect(hpResult, 200); // 25% of 800
    });

    testWidgets('shp and swp use safe area dimensions', (tester) async {
      late double shpResult, swpResult;
      await tester.pumpWidget(buildTestWidget(
        width: 400,
        height: 800,
        padding: const EdgeInsets.only(top: 44, bottom: 34),
        child: Builder(builder: (context) {
          shpResult = context.shp(50);
          swpResult = context.swp(100);
          return const SizedBox();
        }),
      ));
      expect(shpResult, (800 - 44 - 34) * 0.5);
      expect(swpResult, 400);
    });
  });

  group('ResponsiveDimensions - Device Detection', () {
    testWidgets('isMobile at width 599', (tester) async {
      late bool result;
      await tester.pumpWidget(buildTestWidget(
        width: 599,
        height: 800,
        child: Builder(builder: (context) {
          result = context.isMobile;
          return const SizedBox();
        }),
      ));
      expect(result, isTrue);
    });

    testWidgets('isTablet at width 600', (tester) async {
      late bool mobile, tablet;
      await tester.pumpWidget(buildTestWidget(
        width: 600,
        height: 800,
        child: Builder(builder: (context) {
          mobile = context.isMobile;
          tablet = context.isTablet;
          return const SizedBox();
        }),
      ));
      expect(mobile, isFalse);
      expect(tablet, isTrue);
    });

    testWidgets('isDesktop at width 1200', (tester) async {
      late bool tablet, desktop;
      await tester.pumpWidget(buildTestWidget(
        width: 1200,
        height: 800,
        child: Builder(builder: (context) {
          tablet = context.isTablet;
          desktop = context.isDesktop;
          return const SizedBox();
        }),
      ));
      expect(tablet, isFalse);
      expect(desktop, isTrue);
    });

    testWidgets('isWidescreen at width 1920', (tester) async {
      late bool widescreen;
      await tester.pumpWidget(buildTestWidget(
        width: 1920,
        height: 1080,
        child: Builder(builder: (context) {
          widescreen = context.isWidescreen;
          return const SizedBox();
        }),
      ));
      expect(widescreen, isTrue);
    });

    testWidgets('deviceType returns correct enum values', (tester) async {
      Future<DeviceType> getDeviceType(double width) async {
        late DeviceType type;
        await tester.pumpWidget(buildTestWidget(
          width: width,
          height: 800,
          child: Builder(builder: (context) {
            type = context.deviceType;
            return const SizedBox();
          }),
        ));
        return type;
      }

      expect(await getDeviceType(320), DeviceType.mobile);
      expect(await getDeviceType(600), DeviceType.tablet);
      expect(await getDeviceType(1200), DeviceType.desktop);
      expect(await getDeviceType(1920), DeviceType.widescreen);
    });

    testWidgets('device detection uses custom config breakpoints', (tester) async {
      late bool mobile;
      await tester.pumpWidget(buildTestWidget(
        width: 550,
        height: 800,
        config: const AdaptiFlowData(mobileBreakpoint: 500),
        child: Builder(builder: (context) {
          mobile = context.isMobile;
          return const SizedBox();
        }),
      ));
      // 550 >= 500, so not mobile with custom breakpoint
      expect(mobile, isFalse);
    });
  });

  group('ResponsiveDimensions - Scaling', () {
    testWidgets('scale returns correct multiplied values', (tester) async {
      Future<double> getScale(double width, double value) async {
        late double result;
        await tester.pumpWidget(buildTestWidget(
          width: width,
          height: 800,
          child: Builder(builder: (context) {
            result = context.scale(value);
            return const SizedBox();
          }),
        ));
        return result;
      }

      expect(await getScale(400, 16), 16.0);        // mobile: 1x
      expect(await getScale(800, 16), 16 * 1.2);    // tablet: 1.2x
      expect(await getScale(1400, 16), 16 * 1.5);   // desktop: 1.5x
    });

    testWidgets('fontSize returns correct multiplied values', (tester) async {
      Future<double> getFontSize(double width, double size) async {
        late double result;
        await tester.pumpWidget(buildTestWidget(
          width: width,
          height: 800,
          child: Builder(builder: (context) {
            result = context.fontSize(size);
            return const SizedBox();
          }),
        ));
        return result;
      }

      expect(await getFontSize(400, 16), 16.0);         // mobile: 1x
      expect(await getFontSize(800, 16), 16 * 1.15);    // tablet: 1.15x
      expect(await getFontSize(1400, 16), 16 * 1.3);    // desktop: 1.3x
    });
  });

  group('ResponsiveDimensions - Adaptive Values', () {
    testWidgets('adaptivePadding returns correct values per device type', (tester) async {
      Future<double> getPadding(double width) async {
        late double result;
        await tester.pumpWidget(buildTestWidget(
          width: width,
          height: 800,
          child: Builder(builder: (context) {
            result = context.adaptivePadding;
            return const SizedBox();
          }),
        ));
        return result;
      }

      expect(await getPadding(400), 16.0);   // mobile
      expect(await getPadding(800), 24.0);   // tablet
      expect(await getPadding(1400), 32.0);  // desktop
    });

    testWidgets('adaptiveMargin returns correct values per device type', (tester) async {
      Future<double> getMargin(double width) async {
        late double result;
        await tester.pumpWidget(buildTestWidget(
          width: width,
          height: 800,
          child: Builder(builder: (context) {
            result = context.adaptiveMargin;
            return const SizedBox();
          }),
        ));
        return result;
      }

      expect(await getMargin(400), 12.0);   // mobile
      expect(await getMargin(800), 16.0);   // tablet
      expect(await getMargin(1400), 24.0);  // desktop
    });

    testWidgets('adaptiveSpacing returns correct values per device type', (tester) async {
      Future<double> getSpacing(double width) async {
        late double result;
        await tester.pumpWidget(buildTestWidget(
          width: width,
          height: 800,
          child: Builder(builder: (context) {
            result = context.adaptiveSpacing;
            return const SizedBox();
          }),
        ));
        return result;
      }

      expect(await getSpacing(400), 8.0);   // mobile
      expect(await getSpacing(800), 12.0);  // tablet
      expect(await getSpacing(1400), 16.0); // desktop
    });
  });

  group('ResponsiveDimensions - Design-Proportional Scaling', () {
    testWidgets('w() scales proportionally to design width', (tester) async {
      late double result;
      await tester.pumpWidget(buildTestWidget(
        width: 750, // 2x of default designSize.width (375)
        height: 800,
        child: Builder(builder: (context) {
          result = context.w(100);
          return const SizedBox();
        }),
      ));
      expect(result, 200.0); // 100 * (750 / 375)
    });

    testWidgets('h() scales proportionally to design height', (tester) async {
      late double result;
      await tester.pumpWidget(buildTestWidget(
        width: 375,
        height: 1624, // 2x of default designSize.height (812)
        child: Builder(builder: (context) {
          result = context.h(100);
          return const SizedBox();
        }),
      ));
      expect(result, 200.0); // 100 * (1624 / 812)
    });

    testWidgets('r() scales using minimum ratio', (tester) async {
      late double result;
      await tester.pumpWidget(buildTestWidget(
        width: 750,   // ratio: 750/375 = 2.0
        height: 1218, // ratio: 1218/812 = 1.5
        child: Builder(builder: (context) {
          result = context.r(100);
          return const SizedBox();
        }),
      ));
      expect(result, 150.0); // 100 * min(2.0, 1.5) = 150
    });

    testWidgets('sp() clamps font size with min/max', (tester) async {
      late double clamped, unclamped;
      await tester.pumpWidget(buildTestWidget(
        width: 750, // 2x width ratio
        height: 1624, // 2x height ratio
        child: Builder(builder: (context) {
          unclamped = context.sp(16);
          clamped = context.sp(16, min: 20, max: 24);
          return const SizedBox();
        }),
      ));
      expect(unclamped, 32.0); // 16 * 2.0
      expect(clamped, 24.0);   // clamped to max
    });

    testWidgets('sp() applies min clamp', (tester) async {
      late double result;
      await tester.pumpWidget(buildTestWidget(
        width: 187.5, // 0.5x of 375
        height: 406,  // 0.5x of 812
        child: Builder(builder: (context) {
          result = context.sp(16, min: 12);
          return const SizedBox();
        }),
      ));
      expect(result, 12.0); // 16 * 0.5 = 8, clamped to min 12
    });
  });

  group('ResponsiveConstraints', () {
    testWidgets('constrained wraps in ConstrainedBox with maxWidth', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const Text('test').constrained(maxWidth: 500),
          ),
        ),
      );
      // Find ConstrainedBox that is a descendant of Center (our wrapper)
      final cbFinder = find.descendant(
        of: find.byType(Center),
        matching: find.byType(ConstrainedBox),
      );
      final constrainedBox = tester.widget<ConstrainedBox>(cbFinder.first);
      expect(constrainedBox.constraints.maxWidth, 500);
    });

    testWidgets('constrainedBoth sets both max dimensions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const Text('test').constrainedBoth(maxWidth: 500, maxHeight: 300),
          ),
        ),
      );
      final cbFinder = find.descendant(
        of: find.byType(Center),
        matching: find.byType(ConstrainedBox),
      );
      final constrainedBox = tester.widget<ConstrainedBox>(cbFinder.first);
      expect(constrainedBox.constraints.maxWidth, 500);
      expect(constrainedBox.constraints.maxHeight, 300);
    });

    testWidgets('adaptiveConstrained uses config values', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1400, 800)),
          child: MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) {
                return const Text('test').adaptiveConstrained(context);
              }),
            ),
          ),
        ),
      );
      final cbFinder = find.descendant(
        of: find.byType(Center),
        matching: find.byType(ConstrainedBox),
      );
      final constrainedBox = tester.widget<ConstrainedBox>(cbFinder.first);
      expect(constrainedBox.constraints.maxWidth, 1200); // default desktopMaxWidth
    });
  });
}
