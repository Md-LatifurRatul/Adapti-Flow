import 'package:flutter/material.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';
import 'package:adapti_flow_example/pages/desk_top_view.dart';
import 'package:adapti_flow_example/pages/mobile_view.dart';
import 'package:adapti_flow_example/pages/tablet_view.dart';

class MyCustomPage extends StatelessWidget {
  const MyCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ResponsiveText(
          'AdaptiFlow Demo',
          baseFontSize: 20,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: const ResponsiveLayout(
        mobile: MobileView(),
        tablet: TabletView(),
        desktop: DesktopView(),
      ),
    );
  }
}
