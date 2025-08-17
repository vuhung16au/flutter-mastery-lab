// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_widgets_demo/main.dart';

void main() {
  testWidgets('Sydney Widgets Demo app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FlutterWidgetsDemoApp());

    // Verify that the app title is displayed
    expect(find.text('Sydney Widgets Demo'), findsOneWidget);
    
    // Verify that the Basic Widgets page is shown by default
    expect(find.text('Sydney Basic Widgets'), findsOneWidget);
    
    // Verify that the bottom navigation bar is present
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    
    // Verify that the floating action button is present
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
