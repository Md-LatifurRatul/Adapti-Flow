import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';

void main() {
  Widget buildLayout({
    Widget? tablet = const Text('tablet'),
    Widget? desktop = const Text('desktop'),
    Widget? widescreen,
    AdaptiFlowData? config,
  }) {
    Widget app = MaterialApp(
      home: Scaffold(
        body: ResponsiveLayout(
          mobile: const Text('mobile'),
          tablet: tablet,
          desktop: desktop,
          widescreen: widescreen,
        ),
      ),
    );
    if (config != null) {
      app = AdaptiFlow(data: config, child: app);
    }
    return app;
  }

  void setScreenSize(WidgetTester tester, double width, double height) {
    tester.view.physicalSize = Size(width, height);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  group('ResponsiveLayout', () {
    testWidgets('shows mobile widget at 400px', (tester) async {
      setScreenSize(tester, 400, 800);
      await tester.pumpWidget(buildLayout());
      expect(find.text('mobile'), findsOneWidget);
      expect(find.text('tablet'), findsNothing);
    });

    testWidgets('shows tablet widget at 800px', (tester) async {
      setScreenSize(tester, 800, 600);
      await tester.pumpWidget(buildLayout());
      expect(find.text('tablet'), findsOneWidget);
      expect(find.text('mobile'), findsNothing);
    });

    testWidgets('shows desktop widget at 1400px', (tester) async {
      setScreenSize(tester, 1400, 800);
      await tester.pumpWidget(buildLayout());
      expect(find.text('desktop'), findsOneWidget);
    });

    testWidgets('shows widescreen widget at 2000px', (tester) async {
      setScreenSize(tester, 2000, 1000);
      await tester.pumpWidget(buildLayout(
        widescreen: const Text('widescreen'),
      ));
      expect(find.text('widescreen'), findsOneWidget);
    });

    testWidgets('falls back to desktop when widescreen is null at 2000px', (tester) async {
      setScreenSize(tester, 2000, 1000);
      await tester.pumpWidget(buildLayout());
      expect(find.text('desktop'), findsOneWidget);
    });

    testWidgets('falls back to tablet when desktop is null at 1400px', (tester) async {
      setScreenSize(tester, 1400, 800);
      // Explicitly pass null to override the default
      await tester.pumpWidget(buildLayout(desktop: null));
      expect(find.text('tablet'), findsOneWidget);
    });

    testWidgets('falls back to mobile when tablet is null at 800px', (tester) async {
      setScreenSize(tester, 800, 600);
      await tester.pumpWidget(buildLayout(tablet: null));
      expect(find.text('mobile'), findsOneWidget);
    });

    testWidgets('respects custom config breakpoints', (tester) async {
      setScreenSize(tester, 550, 800);
      await tester.pumpWidget(buildLayout(
        config: const AdaptiFlowData(mobileBreakpoint: 500),
      ));
      expect(find.text('tablet'), findsOneWidget);
    });
  });

  group('ResponsiveLayoutBuilder', () {
    testWidgets('provides DeviceType to builder', (tester) async {
      setScreenSize(tester, 800, 600);
      late DeviceType capturedType;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ResponsiveLayoutBuilder(
            builder: (context, constraints, deviceType) {
              capturedType = deviceType;
              return Text(deviceType.name);
            },
          ),
        ),
      ));
      expect(capturedType, DeviceType.tablet);
      expect(find.text('tablet'), findsOneWidget);
    });

    testWidgets('provides correct constraints', (tester) async {
      setScreenSize(tester, 500, 800);
      late double capturedMaxWidth;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ResponsiveLayoutBuilder(
            builder: (context, constraints, deviceType) {
              capturedMaxWidth = constraints.maxWidth;
              return const SizedBox();
            },
          ),
        ),
      ));
      expect(capturedMaxWidth, 500);
    });
  });
}
