import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ui_components_demo/main.dart';

void main() {
  testWidgets('Sydney UI Components app test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FlutterUIComponentsApp());

    // Verify that our app displays the correct title.
    expect(find.text('Sydney UI Components'), findsOneWidget);
  });
}
