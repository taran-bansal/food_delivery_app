import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:food_delivery/features/cart/presentation/screens/cart_screen.dart';
import 'package:food_delivery/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:food_delivery/features/home/presentation/screens/home_screen.dart';
import 'package:food_delivery/features/profile/presentation/screens/profile_screen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Widget createDashboardScreen() {
    return MaterialApp(
      home: const DashboardScreen(),
      navigatorObservers: [mockObserver],
    );
  }

  Future<void> pumpApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  group('DashboardScreen', () {
    testWidgets('should show home screen by default', (WidgetTester tester) async {
      await pumpApp(tester, createDashboardScreen());

      // Verify HomeScreen is shown by default
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(CartScreen), findsNothing);
      expect(find.byType(ProfileScreen), findsNothing);
    });

    testWidgets('should switch between tabs', (WidgetTester tester) async {
      await pumpApp(tester, createDashboardScreen());

      // Tap on cart tab
      await tap(tester, find.byIcon(Icons.shopping_cart));
      
      // Verify CartScreen is shown
      expect(find.byType(CartScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);

      // Tap on profile tab
      await tap(tester, find.byIcon(Icons.person));
      
      // Verify ProfileScreen is shown
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.byType(CartScreen), findsNothing);

      // Tap on home tab
      await tap(tester, find.byIcon(Icons.home));
      
      // Verify HomeScreen is shown again
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(ProfileScreen), findsNothing);
    });

    testWidgets('should have proper bottom navigation bar items', 
        (WidgetTester tester) async {
      await pumpApp(tester, createDashboardScreen());

      // Verify bottom navigation bar items
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      
      // Verify icons
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
}
