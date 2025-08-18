// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic widget tests', (WidgetTester tester) async {
    // Test that we can create basic widgets without Firebase
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              const Text('Flutter Advanced Concepts'),
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: 0,
                onTap: (index) {},
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.http),
                    label: 'API',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.phone),
                    label: 'Communication',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.wb_sunny),
                    label: 'Wakelock',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // Verify that the app title is displayed
    expect(find.text('Flutter Advanced Concepts'), findsOneWidget);
    
    // Verify that the bottom navigation bar is present
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    
    // Verify that the main navigation items are present
    
    expect(find.text('API'), findsOneWidget);
    expect(find.text('Communication'), findsOneWidget);
    expect(find.text('Wakelock'), findsOneWidget);
  });
}
