import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({
    super.key,
    required this.body,
    required this.navigation,
    required this.inspector,
  });

  final Widget body;
  final Widget navigation;
  final Widget inspector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          navigation,
          const VerticalDivider(width: 1),
          Expanded(child: body),
          const VerticalDivider(width: 1),
          SizedBox(
            width: 300, // Fixed width for inspector on desktop
            child: inspector,
          ),
        ],
      ),
    );
  }
}
