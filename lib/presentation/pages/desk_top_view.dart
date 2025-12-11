import 'package:flutter/material.dart';
import 'package:responsive_ui/core/responsive/responsive.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. Use .constrained to prevent stretching on huge monitors
    return Padding(
      padding: EdgeInsets.all(
        context.adaptivePadding,
      ), // Adaptive padding (32px)
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: context.hp(50), // 50% of screen height
              color: Colors.green.shade100,
              child: Center(
                child: Text(
                  'Desktop Panel',
                  style: TextStyle(fontSize: context.fontSize(24)),
                ),
              ),
            ),
          ),
          Spacers.horizontal24, // Consistent 24px horizontal space
          Expanded(
            child: Container(
              height: context.hp(50),
              color: Colors.blue.shade100,
              padding: EdgeInsets.all(context.adaptivePadding),
              child: Text(
                'Adaptive Padding: ${context.adaptivePadding.toStringAsFixed(0)}',
                style: TextStyle(fontSize: context.fontSize(18)),
              ),
            ),
          ),
        ],
      ).constrained(maxWidth: 1400), // Max width of 1400px
    );
  }
}
