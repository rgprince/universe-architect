import 'package:flutter/material.dart';
import 'layouts/desktop_layout.dart';
import 'layouts/mobile_layout.dart';

/// A widget that adapts its layout based on the screen width.
///
/// Switches between a desktop layout (Row with NavigationRail) and
/// a mobile layout (Scaffold with Drawer) at the [breakpoint].
class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold({
    super.key,
    required this.body,
    required this.navigation,
    required this.inspector,
    this.breakpoint = 900,
  });

  /// The main content of the screen.
  final Widget body;

  /// The navigation widget (NavigationRail for desktop, Drawer content for mobile).
  final WidgetBuilder navigation;

  /// The inspector widget (Side panel for desktop, BottomSheet content for mobile).
  final WidgetBuilder inspector;

  /// The width threshold to switch between mobile and desktop layouts.
  final double breakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpoint) {
          return DesktopLayout(
            body: body,
            navigation: navigation(context),
            inspector: inspector(context),
          );
        } else {
          return MobileLayout(
            body: body,
            navigation: navigation(context),
            inspector: inspector(context),
          );
        }
      },
    );
  }
}

