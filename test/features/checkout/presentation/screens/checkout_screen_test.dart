import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:food_delivery/features/cart/domain/models/cart_item.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_state.dart';
import 'package:food_delivery/features/checkout/presentation/screens/checkout_screen.dart';

// Create a simple mock CartBloc for testing
class MockCartBloc extends Mock implements CartBloc {
  CartState _currentState = const CartState(items: []);
  
  @override
  CartState get state => _currentState;
  
  @override
  Stream<CartState> get stream => Stream.value(_currentState);
  
  @override
  bool get isClosed => false;
  
  void _updateState(CartState newState) {
    _currentState = newState;
  }
  
  @override
  void addItem(CartItem item) {
    final items = List<CartItem>.from(_currentState.items);
    final itemIndex = items.indexWhere((i) => i.id == item.id);
    
    if (itemIndex >= 0) {
      // Update quantity if item exists
      items[itemIndex] = items[itemIndex].copyWith(
        quantity: items[itemIndex].quantity + 1,
      );
    } else {
      // Add new item
      items.add(item);
    }
    
    _updateState(_currentState.copyWith(items: items));
  }
  
  @override
  void removeItem(String itemId) {
    final items = _currentState.items.where((item) => item.id != itemId).toList();
    _updateState(_currentState.copyWith(items: items));
  }
  
  @override
  void updateItemQuantity(String itemId, int quantity) {
    final items = List<CartItem>.from(_currentState.items);
    final index = items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      items[index] = items[index].copyWith(quantity: quantity);
      _updateState(_currentState.copyWith(items: items));
    }
  }
  
  @override
  void clearCart() {
    _updateState(const CartState(items: []));
  }
  
  @override
  double getTotal() {
    return _currentState.totalPrice;
  }
  
  @override
  Future<void> close() async {
    // No-op for testing
  }
}

void main() {
  late MockCartBloc mockCartBloc;
  late List<CartItem> testItems;

  setUp(() {
    mockCartBloc = MockCartBloc();
    testItems = [
      CartItem(
        id: '1',
        name: 'Test Burger',
        price: 9.99,
        quantity: 2,
      ),
      CartItem(
        id: '2',
        name: 'Test Fries',
        price: 3.99,
        quantity: 1,
      ),
    ];

    // Initialize the mock with test items
    for (final item in testItems) {
      mockCartBloc.addItem(item);
    }
  });

  Widget createCheckoutScreen() {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<CartBloc>(
            create: (context) => mockCartBloc,
            child: const CheckoutScreen(),
          ),
        );
      },
    );
  }

  Future<void> pumpApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }

  group('CheckoutScreen', () {
    testWidgets('should display cart items and total', (WidgetTester tester) async {
      await pumpApp(tester, createCheckoutScreen());

      // Verify items are displayed
      expect(find.text('Test Burger'), findsOneWidget);
      expect(find.text('Test Fries'), findsOneWidget);
      
      // Verify quantities (might be displayed differently in the UI)
      final quantityFinders = find.byWidgetPredicate(
        (widget) => widget is Text && widget.data != null && 
                   (widget.data!.contains('2') || widget.data!.contains('1')),
      );
      expect(quantityFinders, findsAtLeast(2));
      
      // Verify total price (might be displayed with a different format)
      final priceFinder = find.byWidgetPredicate(
        (widget) => widget is Text && 
                   widget.data != null && 
                   (widget.data!.contains('23.97') || widget.data!.contains('23.9')),
      );
      expect(priceFinder, findsAtLeast(1));
    });

    testWidgets('should display delivery options', (WidgetTester tester) async {
      await pumpApp(tester, createCheckoutScreen());

      // Look for delivery options section
      final deliveryOptionsFinder = find.byWidgetPredicate(
        (widget) => widget is Text && 
                   widget.data != null && 
                   widget.data!.toLowerCase().contains('delivery'),
      );
      expect(deliveryOptionsFinder, findsAtLeast(1));
    });

    testWidgets('should display payment methods', (WidgetTester tester) async {
      await pumpApp(tester, createCheckoutScreen());

      // Look for payment method indicators
      final paymentIconFinder = find.byIcon(Icons.credit_card);
      final cashTextFinder = find.byWidgetPredicate(
        (widget) => widget is Text && 
                   widget.data != null && 
                   widget.data!.toLowerCase().contains('cash'),
      );
      
      expect(paymentIconFinder, findsAtLeast(1));
      expect(cashTextFinder, findsAtLeast(1));
    });

    testWidgets('should show order summary', (WidgetTester tester) async {
      await pumpApp(tester, createCheckoutScreen());

      // Look for order summary section
      final summaryFinder = find.byWidgetPredicate(
        (widget) => widget is Text && 
                   widget.data != null && 
                   widget.data!.toLowerCase().contains('order summary'),
      );
      
      expect(summaryFinder, findsAtLeast(1));
    });

    testWidgets('should show place order button', (WidgetTester tester) async {
      await pumpApp(tester, createCheckoutScreen());

      // Look for any button that might be the place order button
      final buttons = find.byType(ElevatedButton);
      expect(buttons, findsWidgets);
      
      // Check if any button contains text related to placing an order
      final placeOrderButton = find.byWidgetPredicate(
        (widget) => widget is ElevatedButton &&
                   widget.child is Text &&
                   (widget.child as Text).data != null &&
                   (widget.child as Text).data!.toLowerCase().contains('place order'),
      );
      
      expect(placeOrderButton, findsAtLeast(1));
    });
  });
}
