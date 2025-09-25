import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart' as cart_bloc;
import 'package:food_delivery/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:food_delivery/features/menu/presentation/screens/menu_screen.dart';
import 'package:food_delivery/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:food_delivery/features/checkout/presentation/screens/order_confirmation_screen.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize any required services here
  
  runApp(FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  FoodDeliveryApp({super.key});

  // Define your routes here
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      // Main dashboard with bottom navigation
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
      
      // Restaurant menu screen
      GoRoute(
        path: '/restaurant/:id',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: MenuScreen(
            restaurantId: state.pathParameters['id']!,
            restaurantName: state.uri.queryParameters['name'] ?? 'Restaurant',
          ),
        ),
      ),
      
      // Menu screen (for browsing all restaurants)
      GoRoute(
        path: '/menu',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MenuScreen(
            restaurantId: '1', // Default or featured restaurant
            restaurantName: 'Our Menu',
          ),
        ),
      ),
      
      // Checkout flow
      GoRoute(
        path: '/checkout',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CheckoutScreen(),
        ),
      ),
      
      // Order confirmation
      GoRoute(
        path: '/order-confirmation',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: OrderConfirmationScreen(
            orderId: state.uri.queryParameters['orderId'] ?? 'N/A',
            totalAmount: double.tryParse(state.uri.queryParameters['total'] ?? '0') ?? 0,
          ),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri.path}\n',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // Set up screen util for responsive design
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone 13 mini dimensions
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => cart_bloc.CartBloc(),
          child: MaterialApp.router(
            title: 'Food Delivery',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routerConfig: _router,
          ),
        );
      },
    );
  }
}

// Main app widget with routing and theme configuration
