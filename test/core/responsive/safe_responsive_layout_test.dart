import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_ui/core/responsive/responsive.dart';

void main() {
  group('SafeResponsiveLayout', () {
    testWidgets('wraps content in SafeArea', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SafeResponsiveLayout(
              child: Text('content'),
            ),
          ),
        ),
      );
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
    });

    testWidgets('wraps content in SingleChildScrollView when enableScroll is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SafeResponsiveLayout(
              child: Text('content'),
            ),
          ),
        ),
      );
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('does not wrap in SingleChildScrollView when enableScroll is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SafeResponsiveLayout(
              enableScroll: false,
              child: Text('content'),
            ),
          ),
        ),
      );
      expect(find.byType(SingleChildScrollView), findsNothing);
    });

    testWidgets('applies padding when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SafeResponsiveLayout(
              enableScroll: false,
              padding: EdgeInsets.all(16),
              child: Text('padded'),
            ),
          ),
        ),
      );
      // Find the specific Padding widget with our EdgeInsets value
      // (SafeArea also adds an internal Padding, so we match by value)
      final paddingFinder = find.byWidgetPredicate(
        (widget) => widget is Padding && widget.padding == const EdgeInsets.all(16),
      );
      expect(paddingFinder, findsOneWidget);
    });

    testWidgets('applies maxWidth constraint when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SafeResponsiveLayout(
              maxWidth: 600,
              child: Text('constrained'),
            ),
          ),
        ),
      );
      // Find ConstrainedBox that is a descendant of SafeResponsiveLayout
      final cbFinder = find.descendant(
        of: find.byType(SafeResponsiveLayout),
        matching: find.byType(ConstrainedBox),
      );
      expect(cbFinder, findsOneWidget);
      final constrainedBox = tester.widget<ConstrainedBox>(cbFinder);
      expect(constrainedBox.constraints.maxWidth, 600);
    });

    testWidgets('passes scroll physics when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SafeResponsiveLayout(
              physics: BouncingScrollPhysics(),
              child: Text('content'),
            ),
          ),
        ),
      );
      final scrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      expect(scrollView.physics, isA<BouncingScrollPhysics>());
    });

    testWidgets('maintainBottomViewPadding is passed to SafeArea', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SafeResponsiveLayout(
              maintainBottomViewPadding: false,
              child: Text('content'),
            ),
          ),
        ),
      );
      final safeArea = tester.widget<SafeArea>(find.byType(SafeArea));
      expect(safeArea.maintainBottomViewPadding, isFalse);
    });
  });

  group('SafeMobileLayout backward compatibility', () {
    testWidgets('SafeMobileLayout typedef works', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            // ignore: deprecated_member_use_from_same_package
            body: SafeMobileLayout(
              child: Text('backward compat'),
            ),
          ),
        ),
      );
      expect(find.text('backward compat'), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
    });
  });
}
