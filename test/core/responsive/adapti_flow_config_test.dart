import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_ui/core/responsive/responsive.dart';

void main() {
  group('AdaptiFlowData', () {
    test('default values match original hardcoded values', () {
      const config = AdaptiFlowData();
      expect(config.mobileBreakpoint, 600);
      expect(config.desktopBreakpoint, 1200);
      expect(config.widescreenBreakpoint, 1920);
      expect(config.designSize, const Size(375, 812));
      expect(config.mobileScaleFactor, 1.0);
      expect(config.tabletScaleFactor, 1.2);
      expect(config.desktopScaleFactor, 1.5);
      expect(config.mobileFontScale, 1.0);
      expect(config.tabletFontScale, 1.15);
      expect(config.desktopFontScale, 1.3);
      expect(config.mobilePadding, 16.0);
      expect(config.tabletPadding, 24.0);
      expect(config.desktopPadding, 32.0);
      expect(config.mobileMargin, 12.0);
      expect(config.tabletMargin, 16.0);
      expect(config.desktopMargin, 24.0);
      expect(config.mobileSpacing, 8.0);
      expect(config.tabletSpacing, 12.0);
      expect(config.desktopSpacing, 16.0);
      expect(config.tabletMaxWidth, 900);
      expect(config.desktopMaxWidth, 1200);
    });

    test('copyWith preserves non-overridden values', () {
      const original = AdaptiFlowData();
      final modified = original.copyWith(mobileBreakpoint: 500);
      expect(modified.mobileBreakpoint, 500);
      expect(modified.desktopBreakpoint, 1200);
      expect(modified.designSize, const Size(375, 812));
    });

    test('copyWith overrides specified values', () {
      const original = AdaptiFlowData();
      final modified = original.copyWith(
        desktopBreakpoint: 1024,
        designSize: const Size(390, 844),
        desktopPadding: 48,
      );
      expect(modified.desktopBreakpoint, 1024);
      expect(modified.designSize, const Size(390, 844));
      expect(modified.desktopPadding, 48);
      expect(modified.mobileBreakpoint, 600); // unchanged
    });

    test('equality compares all fields', () {
      const a = AdaptiFlowData();
      const b = AdaptiFlowData();
      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));

      final c = a.copyWith(mobileBreakpoint: 500);
      expect(a, isNot(equals(c)));
    });
  });

  group('AdaptiFlow InheritedWidget', () {
    Widget buildApp({AdaptiFlowData? config, required Widget child}) {
      if (config != null) {
        return AdaptiFlow(
          data: config,
          child: MaterialApp(home: Scaffold(body: child)),
        );
      }
      return MaterialApp(home: Scaffold(body: child));
    }

    testWidgets('of() returns defaults when no AdaptiFlow in tree', (tester) async {
      late AdaptiFlowData result;
      await tester.pumpWidget(buildApp(
        child: Builder(builder: (context) {
          result = AdaptiFlow.of(context);
          return const SizedBox();
        }),
      ));
      expect(result.mobileBreakpoint, 600);
      expect(result.desktopBreakpoint, 1200);
    });

    testWidgets('of() returns custom config when AdaptiFlow is in tree', (tester) async {
      late AdaptiFlowData result;
      await tester.pumpWidget(buildApp(
        config: const AdaptiFlowData(mobileBreakpoint: 500),
        child: Builder(builder: (context) {
          result = AdaptiFlow.of(context);
          return const SizedBox();
        }),
      ));
      expect(result.mobileBreakpoint, 500);
    });

    testWidgets('maybeOf() returns config without creating dependency', (tester) async {
      late AdaptiFlowData result;
      await tester.pumpWidget(buildApp(
        config: const AdaptiFlowData(desktopPadding: 48),
        child: Builder(builder: (context) {
          result = AdaptiFlow.maybeOf(context);
          return const SizedBox();
        }),
      ));
      expect(result.desktopPadding, 48);
    });

    testWidgets('updateShouldNotify returns true when data changes', (tester) async {
      const data1 = AdaptiFlowData();
      const data2 = AdaptiFlowData(mobileBreakpoint: 500);

      const widget1 = AdaptiFlow(data: data1, child: SizedBox());
      const widget2 = AdaptiFlow(data: data2, child: SizedBox());
      const widget3 = AdaptiFlow(data: data1, child: SizedBox());

      expect(widget2.updateShouldNotify(widget1), isTrue);
      expect(widget3.updateShouldNotify(widget1), isFalse);
    });
  });
}
