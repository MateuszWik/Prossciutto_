
import 'package:flutter_test/flutter_test.dart';

import 'package:mateusz/main.dart'; // Import your main.dart with MyApp

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify initial state or UI elements here.
    // You might want to change the following expectations to fit your UI.
    // For example, check for a widget with text 'Hi' from your Menu screen.

    expect(find.text('Hi'), findsOneWidget);

    // Add more tests as needed...
  });
}
