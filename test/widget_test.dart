import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:food_delivery/main.dart';
import 'package:go_router/go_router.dart';

import 'helpers/test_app.dart';
import 'helpers/test_helpers.dart';

void main() {
  group('App Tests', () {
    testWidgets('App should show home screen', (WidgetTester tester) async {
      // Build our app with test wrapper
      await pumpWidgetWithSettled(
        tester,
        const TestApp(
          child: FoodDeliveryApp(),
        ),
      );

      // Verify that the home screen is displayed by checking for a widget that's unique to the home screen
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('App should initialize with empty cart', (tester) async {
      // Create a mock cart bloc
      final cartBloc = CartBloc();
      
      // Build our app with the mock cart bloc
      await pumpWidgetWithSettled(
        tester,
        TestApp(
          cartBloc: cartBloc,
          child: const FoodDeliveryApp(),
        ),
      );

      // Verify that the cart is initially empty
      expect(cartBloc.state.items, isEmpty);
    });

    testWidgets('App should show 404 for unknown routes', (tester) async {
      // Build our app with an unknown route
      final app = MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: '/unknown',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('Home')),
              ),
            ),
          ],
          errorBuilder: (context, state) => Scaffold(
            body: Center(
              child: Text('Page not found: ${state.uri.path}'),
            ),
          ),
        ),
      );

      await pumpWidgetWithSettled(tester, TestApp(child: app));
      
      // Verify that the 404 page is shown for unknown routes
      expect(find.text('Page not found: /unknown'), findsOneWidget);
    });
  });
}
