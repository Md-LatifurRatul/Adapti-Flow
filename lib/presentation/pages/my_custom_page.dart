import 'package:flutter/material.dart';
import 'package:responsive_ui/core/responsive/responsive.dart';
import 'package:responsive_ui/presentation/pages/desk_top_view.dart';
import 'package:responsive_ui/presentation/pages/mobile_view.dart';
import 'package:responsive_ui/presentation/pages/tablet_view.dart';

class MyCustomPage extends StatelessWidget {
  const MyCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Use ResponsiveLayout to pick the correct view based on screen size
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Custom UI',
          style: TextStyle(
            fontSize: context.fontSize(20),
          ), // Font size scales automatically
        ),
      ),
      body: ResponsiveLayout(
        mobile: const MobileView(),
        tablet: const TabletView(),
        desktop: const DesktopView(),
      ),
    );
  }
}
