import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/main.dart';

void main() {
  testWidgets('Hello Flutter app test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());

    // Verify that our app displays the correct text.
    expect(find.text('G\'day from Sydney!'), findsOneWidget);
  });
}
