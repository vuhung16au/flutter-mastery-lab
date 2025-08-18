// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_accessing_device/main.dart';

void main() {
  testWidgets('Device Access App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DeviceAccessApp());

    // Verify that the app loads with the correct title
    expect(find.text('Device Access Demo'), findsOneWidget);
    
    // Verify that device information is displayed
    expect(find.text('Device Information'), findsOneWidget);
    
    // Verify that image and video buttons are present
    expect(find.text('Image & Video'), findsOneWidget);
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Gallery'), findsOneWidget);
    
    // Verify that notifications section is present
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Show Now'), findsOneWidget);
    expect(find.text('Schedule'), findsOneWidget);
    
    // Verify that system controls section is present
    expect(find.text('System Controls'), findsOneWidget);
    
    // Wait for any pending timers to complete
    await tester.pumpAndSettle();
  });
}
