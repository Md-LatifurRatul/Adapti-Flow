import 'package:flutter/material.dart';
import 'package:responsive_ui/presentation/pages/my_custom_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive UI Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyCustomPage(),
    );
  }
}
