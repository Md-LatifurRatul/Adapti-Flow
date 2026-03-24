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
  group('responsiveValue function', () {
    testWidgets('returns mobile value on mobile', (tester) async {
      late int result;
      await tester.pumpWidget(buildWithWidth(400, Builder(
        builder: (context) {
          result = responsiveValue(context, mobile: 1, tablet: 2, desktop: 3);
          return const SizedBox();
        },
      )));
      expect(result, 1);
    });

    testWidgets('returns tablet value on tablet', (tester) async {
      late int result;
      await tester.pumpWidget(buildWithWidth(800, Builder(
        builder: (context) {
          result = responsiveValue(context, mobile: 1, tablet: 2, desktop: 3);
          return const SizedBox();
        },
      )));
      expect(result, 2);
    });

    testWidgets('returns desktop value on desktop', (tester) async {
      late int result;
      await tester.pumpWidget(buildWithWidth(1400, Builder(
        builder: (context) {
          result = responsiveValue(context, mobile: 1, tablet: 2, desktop: 3);
          return const SizedBox();
        },
      )));
      expect(result, 3);
    });

    testWidgets('falls back to mobile when tablet is null', (tester) async {
      late int result;
      await tester.pumpWidget(buildWithWidth(800, Builder(
        builder: (context) {
          result = responsiveValue(context, mobile: 1);
          return const SizedBox();
        },
      )));
      expect(result, 1);
    });

    testWidgets('falls back to tablet when desktop is null', (tester) async {
      late int result;
      await tester.pumpWidget(buildWithWidth(1400, Builder(
        builder: (context) {
          result = responsiveValue(context, mobile: 1, tablet: 2);
          return const SizedBox();
        },
      )));
      expect(result, 2);
    });

    testWidgets('returns widescreen value on widescreen', (tester) async {
      late int result;
      await tester.pumpWidget(buildWithWidth(2000, Builder(
        builder: (context) {
          result = responsiveValue(context, mobile: 1, tablet: 2, desktop: 3, widescreen: 4);
          return const SizedBox();
        },
      )));
      expect(result, 4);
    });
  });

  group('ResponsiveValue class', () {
    testWidgets('of() returns correct value', (tester) async {
      const rv = ResponsiveValue<String>(
        mobile: 'small',
        tablet: 'medium',
        desktop: 'large',
      );
      late String result;
      await tester.pumpWidget(buildWithWidth(800, Builder(
        builder: (context) {
          result = rv.of(context);
          return const SizedBox();
        },
      )));
      expect(result, 'medium');
    });

    testWidgets('getValue() works same as of()', (tester) async {
      const rv = ResponsiveValue<int>(mobile: 10, desktop: 30);
      late int ofResult, getValueResult;
      await tester.pumpWidget(buildWithWidth(1400, Builder(
        builder: (context) {
          ofResult = rv.of(context);
          getValueResult = rv.getValue(context);
          return const SizedBox();
        },
      )));
      expect(ofResult, 30);
      expect(getValueResult, 30);
    });
  });

  group('orientationValue function', () {
    testWidgets('returns portrait value in portrait', (tester) async {
      late double result;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) {
                result = orientationValue(context, portrait: 16.0, landscape: 24.0);
                return const SizedBox();
              }),
            ),
          ),
        ),
      );
      expect(result, 16.0);
    });

    testWidgets('returns landscape value in landscape', (tester) async {
      late double result;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(800, 400)),
          child: MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) {
                result = orientationValue(context, portrait: 16.0, landscape: 24.0);
                return const SizedBox();
              }),
            ),
          ),
        ),
      );
      expect(result, 24.0);
    });
  });
}
