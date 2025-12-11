// Mobile/Small Screen View (< 600px)
import 'package:flutter/material.dart';
import 'package:responsive_ui/core/responsive/responsive.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Use SafeMobileLayout for anti-overflow and safe area handling
    return SafeMobileLayout(
      padding: .symmetric(
        horizontal: context.wp(5),
      ), // 5% of screen width padding
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            height: context.hp(25), // 25% of screen height
            color: Colors.red.shade100,
          ),
          Spacers.vertical16, // Consistent 16px vertical space
          Text(
            'Mobile Layout: ${context.isPortrait ? 'Portrait' : 'Landscape'}',
            style: TextStyle(fontSize: context.fontSize(16)),
          ),
          Spacers.vertical8,
          // // Row to demonstrate horizontal spacer
          // Row(
          //   children: [
          //     const Text('Item 1'),
          //     Spacers.horizontal8, // 8px horizontal space
          //     const Text('Item 2'),
          //   ],
          // ),
          Row(
            children: [
              // Wrap Text in Expanded to share available space
              Expanded(
                child: Text(
                  'Item 1: ${context.isMobile ? 'Mobile' : 'Not Mobile'}',
                  // Make sure font size scales down for very small screens
                  style: TextStyle(fontSize: context.fontSize(10)),
                  maxLines:
                      1, // Prevent text from wrapping and causing its own height issues
                  overflow: TextOverflow
                      .ellipsis, // Add ellipsis if it still doesn't fit
                ),
              ),
              Spacers.horizontal8,
              // 💡 FIX: Wrap Text in Expanded to share available space
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
          Spacers.vertical32,
          // Input field to test keyboard guard
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
