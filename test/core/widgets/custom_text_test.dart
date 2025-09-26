import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/core/widgets/custom_text.dart';

void main() {
  group('CustomText Widget Tests', () {
    testWidgets('should display text correctly', (WidgetTester tester) async {
      const testText = 'Hello, World!';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: CustomText(testText),
            ),
          ),
        ),
      );

      // Verify the text is displayed
      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('should apply custom styling', (WidgetTester tester) async {
      const testText = 'Styled Text';
      const testColor = Colors.red;
      const testFontSize = 20.0;
      const testFontWeight = FontWeight.bold;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: CustomText(
                testText,
                color: testColor,
                fontSize: testFontSize,
                fontWeight: testFontWeight,
              ),
            ),
          ),
        ),
      );

      // Find the text widget using find.text and verify it exists
      final textFinder = find.text(testText);
      expect(textFinder, findsOneWidget);
      
      // Get the text widget and verify its properties
      final textWidget = tester.widget<Text>(textFinder);
      final textStyle = textWidget.style;

      // Verify styling
      expect(textStyle?.color, testColor);
      expect(textStyle?.fontSize, testFontSize);
      expect(textStyle?.fontWeight, testFontWeight);
    });

    testWidgets('should use displayLarge constructor correctly', (WidgetTester tester) async {
      const testText = 'Display Large';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: CustomText.displayLarge(testText),
            ),
          ),
        ),
      );

      final textFinder = find.text(testText);
      final textWidget = tester.widget<Text>(textFinder);
      final textStyle = textWidget.style;

      // Verify displayLarge styles
      expect(textWidget.data, testText);
      expect(textStyle?.fontSize, 32);
      expect(textStyle?.fontWeight, FontWeight.w700);
      expect(textStyle?.height, 1.2);
      expect(textStyle?.letterSpacing, -0.5);
    });

    testWidgets('should handle maxLines and overflow', (WidgetTester tester) async {
      const testText = 'This is a very long text that should be truncated';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 100,
                child: CustomText(
                  testText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      );

      final textFinder = find.text(testText);
      final textWidget = tester.widget<Text>(textFinder);
      
      // Verify text overflow handling
      expect(textWidget.maxLines, 1);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
