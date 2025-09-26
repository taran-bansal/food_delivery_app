import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Helper function to create a testable widget with MaterialApp
Widget createTestableWidget(Widget child) {
  return MaterialApp(
    home: Material(child: child),
  );
}

// Helper function to find a widget by its key
Finder findWidgetByKey(Key key) => find.byKey(key);

// Helper function to find a widget by its type
Finder findWidgetByType<T>() => find.byType(T);

// Helper function to find a widget by its text
Finder findWidgetByText(String text) => find.text(text);

// Helper function to find a widget by its icon
Finder findWidgetByIcon(IconData icon) => find.byIcon(icon);

// Helper function to pump a widget with a small duration
Future<void> pumpWidgetWithSettled(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();
}

// Helper function to tap a widget
Future<void> tapWidget(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump();
}

// Helper function to enter text into a text field
Future<void> enterTextIntoField(
    WidgetTester tester, 
    Finder finder, 
    String text
) async {
  await tester.enterText(finder, text);
  await tester.pump();
}
