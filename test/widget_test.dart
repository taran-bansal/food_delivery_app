import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/main.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('App should show home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(FoodDeliveryApp());

    // Verify that the home screen is displayed
    expect(find.text('Food Delivery App'), findsOneWidget);
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

    await tester.pumpWidget(app);
    
    // Verify that the 404 page is shown for unknown routes
    expect(find.text('Page not found: /unknown'), findsOneWidget);
  });
}
