import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';

void main() {
  group('ResponsiveSpacer', () {
    testWidgets('creates vertical SizedBox inside Column', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Text('A'),
                ResponsiveSpacer(size: 24),
                Text('B'),
              ],
            ),
          ),
        ),
      );
      // Find the ResponsiveSpacer widget, then check its rendered SizedBox
      final spacerFinder = find.byType(ResponsiveSpacer);
      expect(spacerFinder, findsOneWidget);

      // The ResponsiveSpacer renders a SizedBox as its child
      final sizedBoxFinder = find.descendant(
        of: spacerFinder,
        matching: find.byType(SizedBox),
      );
      final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      expect(sizedBox.height, 24);
      expect(sizedBox.width, isNull);
    });

    testWidgets('creates horizontal SizedBox inside Row', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                Text('A'),
                ResponsiveSpacer(size: 16),
                Text('B'),
              ],
            ),
          ),
        ),
      );
      final spacerFinder = find.byType(ResponsiveSpacer);
      final sizedBoxFinder = find.descendant(
        of: spacerFinder,
        matching: find.byType(SizedBox),
      );
      final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      expect(sizedBox.width, 16);
      expect(sizedBox.height, isNull);
    });

    testWidgets('defaults to vertical when no Flex parent', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResponsiveSpacer(size: 12),
            ),
          ),
        ),
      );
      final spacerFinder = find.byType(ResponsiveSpacer);
      final sizedBoxFinder = find.descendant(
        of: spacerFinder,
        matching: find.byType(SizedBox),
      );
      final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      expect(sizedBox.height, 12);
      expect(sizedBox.width, isNull);
    });

    testWidgets('default size is 16', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [ResponsiveSpacer()],
            ),
          ),
        ),
      );
      final spacerFinder = find.byType(ResponsiveSpacer);
      final sizedBoxFinder = find.descendant(
        of: spacerFinder,
        matching: find.byType(SizedBox),
      );
      final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      expect(sizedBox.height, 16);
    });
  });

  group('Spacers constants', () {
    test('canonical spacers have correct sizes', () {
      expect(Spacers.s4.size, 4);
      expect(Spacers.s8.size, 8);
      expect(Spacers.s12.size, 12);
      expect(Spacers.s16.size, 16);
      expect(Spacers.s24.size, 24);
      expect(Spacers.s32.size, 32);
      expect(Spacers.s48.size, 48);
    });

    testWidgets('Spacers.of creates custom size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [Spacers.of(20)],
            ),
          ),
        ),
      );
      final spacerFinder = find.byType(ResponsiveSpacer);
      final sizedBoxFinder = find.descendant(
        of: spacerFinder,
        matching: find.byType(SizedBox),
      );
      final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      expect(sizedBox.height, 20);
    });
  });
}
