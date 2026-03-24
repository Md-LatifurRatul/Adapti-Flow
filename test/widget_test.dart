import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_ui/app.dart';

void main() {
  testWidgets('App smoke test — renders without errors', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('AdaptiFlow Demo'), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
