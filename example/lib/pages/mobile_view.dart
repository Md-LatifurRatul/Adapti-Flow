import 'package:flutter/material.dart';
import 'package:adapti_flow/core/responsive/responsive.dart';

/// Mobile/Small Screen View (< 600px)
class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeResponsiveLayout(
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.hp(25),
            color: Colors.red.shade100,
          ),
          Spacers.s16,
          Text(
            'Mobile Layout: ${context.isPortrait ? 'Portrait' : 'Landscape'}',
            style: TextStyle(fontSize: context.fontSize(16)),
          ),
          Spacers.s8,
          Row(
            children: [
              Expanded(
                child: Text(
                  'Item 1: ${context.isMobile ? 'Mobile' : 'Not Mobile'}',
                  style: TextStyle(fontSize: context.fontSize(10)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacers.s8,
              Expanded(
                child: Text(
                  'Item 2',
                  style: TextStyle(fontSize: context.fontSize(10)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Spacers.s32,
          const TextField(
            decoration: InputDecoration(
              labelText: 'Focus here to test keyboard guard',
            ),
          ),
        ],
      ),
    );
  }
}
