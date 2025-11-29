import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({
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
      appBar: AppBar(
        title: const Text('Universe Architect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => inspector,
              );
            },
          ),
        ],
      ),
      drawer: Drawer(child: navigation),
      body: body,
    );
  }
}
