import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:universe_architect/ui/responsive_scaffold.dart';
import 'package:universe_architect/ui/layouts/desktop_layout.dart';
import 'package:universe_architect/ui/layouts/mobile_layout.dart';
import 'package:universe_architect/ui/editor/editor_screen.dart';

void main() {
  group('ResponsiveScaffold Tests', () {
    testWidgets('shows DesktopLayout on wide screens', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveScaffold(
            body: const Text('Body'),
            navigation: (context) => const Text('Navigation'),
            inspector: (context) => const Text('Inspector'),
          ),
        ),
      );

      expect(find.byType(DesktopLayout), findsOneWidget);
      expect(find.byType(MobileLayout), findsNothing);
      
      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('shows MobileLayout on narrow screens', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveScaffold(
            body: const Text('Body'),
            navigation: (context) => const Text('Navigation'),
            inspector: (context) => const Text('Inspector'),
          ),
        ),
      );

      expect(find.byType(MobileLayout), findsOneWidget);
      expect(find.byType(DesktopLayout), findsNothing);
      
      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('Layout Tests', () {
    testWidgets('DesktopLayout displays all three panes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DesktopLayout(
            body: Text('Body Content'),
            navigation: Text('Nav Rail'),
            inspector: Text('Inspector Panel'),
          ),
        ),
      );

      expect(find.text('Body Content'), findsOneWidget);
      expect(find.text('Nav Rail'), findsOneWidget);
      expect(find.text('Inspector Panel'), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('MobileLayout hides navigation and inspector initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MobileLayout(
            body: Text('Body Content'),
            navigation: Text('Drawer Nav'),
            inspector: Text('Bottom Sheet Inspector'),
          ),
        ),
      );

      expect(find.text('Body Content'), findsOneWidget);
      expect(find.text('Drawer Nav'), findsNothing);
      expect(find.text('Bottom Sheet Inspector'), findsNothing);
    });

    testWidgets('MobileLayout opens drawer for navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MobileLayout(
            body: Text('Body Content'),
            navigation: Text('Drawer Nav'),
            inspector: Text('Bottom Sheet Inspector'),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text('Drawer Nav'), findsOneWidget);
    });
  });

  group('EditorScreen Tests', () {
    testWidgets('shows toolbar and editor', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: EditorScreen()),
          ),
        ),
      );

      expect(find.byType(QuillSimpleToolbar), findsOneWidget);
      expect(find.byType(QuillEditor), findsOneWidget);
    });

    testWidgets('toggles HTML view', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: EditorScreen()),
          ),
        ),
      );

      // Initially in editor mode
      expect(find.byType(QuillEditor), findsOneWidget);
      expect(find.byType(SelectableText), findsNothing);

      // Tap "View HTML" button
      await tester.tap(find.byKey(const Key('view_html_button')));
      await tester.pump();

      // Now in HTML mode
      expect(find.byType(QuillEditor), findsNothing);
      expect(find.byType(SelectableText), findsOneWidget);
      
      // Tap "Edit Text" button
      await tester.tap(find.byKey(const Key('view_html_button')));
      await tester.pump();
      
      // Back to editor mode
      expect(find.byType(QuillEditor), findsOneWidget);
    });
  });
}
