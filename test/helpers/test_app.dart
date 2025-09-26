import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart';

class TestApp extends StatelessWidget {
  final Widget child;
  final CartBloc? cartBloc;

  const TestApp({
    super.key,
    required this.child,
    this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => cartBloc ?? CartBloc(),
        ),
        // Add other providers as needed
      ],
      child: MaterialApp(
        title: 'Food Delivery Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: child,
      ),
    );
  }
}

// Helper function to create a testable widget with all necessary providers
Widget wrapWithMaterialApp(Widget child) {
  return TestApp(
    child: Material(
      child: child,
    ),
  );
}
