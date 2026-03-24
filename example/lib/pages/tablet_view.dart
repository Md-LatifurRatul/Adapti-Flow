import 'package:flutter/material.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';

class TabletView extends StatelessWidget {
  const TabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(context.adaptivePadding),
        width: context.wp(90),
        child: Column(
          children: [
            Text(
              'Tablet View',
              style: TextStyle(fontSize: context.fontSize(20)),
            ),
            Spacers.s16,
            Row(
              children: [
                Expanded(child: Container(height: 100, color: Colors.orange)),
                Spacers.s12,
                Expanded(child: Container(height: 100, color: Colors.purple)),
              ],
            ),
          ],
        ),
      ).adaptiveConstrained(context),
    );
  }
}
