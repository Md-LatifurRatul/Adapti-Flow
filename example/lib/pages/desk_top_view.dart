import 'package:flutter/material.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.adaptivePadding),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: context.hp(50),
              color: Colors.green.shade100,
              child: Center(
                child: Text(
                  'Desktop Panel',
                  style: TextStyle(fontSize: context.fontSize(24)),
                ),
              ),
            ),
          ),
          Spacers.s24,
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
      ).constrained(maxWidth: 1400),
    );
  }
}
