import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget test', (WidgetTester tester) async {
    // Build a MaterialApp with a Text widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Hello, world!'),
          ),
        ),
      ),
    );

    // Verify that the Text widget is displayed
    expect(find.text('Hello, world!'), findsOneWidget);
  });
}
