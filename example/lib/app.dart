import 'package:flutter/material.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';
import 'package:adapti_flow_example/pages/my_custom_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiFlow(
      // All defaults — customize any field to override:
      // data: AdaptiFlowData(
      //   mobileBreakpoint: 500,
      //   designSize: Size(390, 844),
      //   desktopPadding: 48,
      // ),
      data: const AdaptiFlowData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AdaptiFlow Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyCustomPage(),
      ),
    );
  }
}
