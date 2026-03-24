import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adapti_flow/adapti_flow.dart';

void main() {
  testWidgets('AdaptiFlow package smoke test — core widgets render', (tester) async {
    await tester.pumpWidget(
      const AdaptiFlow(
        data: AdaptiFlowData(),
        child: MaterialApp(
          home: Scaffold(
            body: SafeResponsiveLayout(
              child: ResponsiveText('AdaptiFlow', baseFontSize: 16),
            ),
          ),
        ),
      ),
    );
    expect(find.text('AdaptiFlow'), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
  });
}
