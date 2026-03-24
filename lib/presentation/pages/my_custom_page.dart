import 'package:flutter/material.dart';
import 'package:responsive_ui/core/responsive/responsive.dart';
import 'package:responsive_ui/presentation/pages/desk_top_view.dart';
import 'package:responsive_ui/presentation/pages/mobile_view.dart';
import 'package:responsive_ui/presentation/pages/tablet_view.dart';

class MyCustomPage extends StatelessWidget {
  const MyCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveText(
          'AdaptiFlow Demo',
          baseFontSize: 20,
          style: const TextStyle(fontWeight: FontWeight.w600),
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
