import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/features/cart/domain/models/cart_item.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_event.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_state.dart';

void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;
    final testItem1 = CartItem(
      id: '1',
      name: 'Burger',
      price: 9.99,
      quantity: 1,
    );
    
    final testItem2 = CartItem(
      id: '2',
      name: 'Pizza',
      price: 12.99,
      quantity: 1,
    );

    setUp(() {
      cartBloc = CartBloc();
    });

    tearDown(() {
      cartBloc.close();
    });

    test('initial state is CartState with empty items', () {
      expect(cartBloc.state, const CartState(items: []));
    });

    blocTest<CartBloc, CartState>(
      'emits [CartState] with one item when AddToCart is added',
      build: () => cartBloc,
      act: (bloc) => bloc.add(AddToCart(testItem1)),
      expect: () => [
        CartState(items: [testItem1]),
      ],
    );

    blocTest<CartBloc, CartState>(
      'increments quantity when adding existing item',
      build: () => cartBloc,
      seed: () => CartState(items: [testItem1]),
      act: (bloc) => bloc.add(AddToCart(testItem1)),
      expect: () => [
        CartState(
          items: [testItem1.copyWith(quantity: testItem1.quantity + 1)],
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'removes item when RemoveFromCart is added',
      build: () => cartBloc,
      seed: () => CartState(items: [testItem1, testItem2]),
      act: (bloc) => bloc.add(RemoveFromCart(testItem1.id)),
      expect: () => [
        CartState(items: [testItem2]),
      ],
    );

    blocTest<CartBloc, CartState>(
      'updates item when UpdateCartItem is added',
      build: () => cartBloc,
      seed: () => CartState(items: [testItem1]),
      act: (bloc) {
        final updatedItem = testItem1.copyWith(quantity: 3);
        bloc.add(UpdateCartItem(updatedItem));
      },
      expect: () => [
        CartState(
          items: [testItem1.copyWith(quantity: 3)],
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'clears all items when ClearCart is added',
      build: () => cartBloc,
      seed: () => CartState(items: [testItem1, testItem2]),
      act: (bloc) => bloc.add(const ClearCart()),
      expect: () => [
        const CartState(items: []),
      ],
    );

    test('calculates total price correctly', () {
      final state = CartState(items: [
        CartItem(id: '1', name: 'Item 1', price: 10.0, quantity: 2),
        CartItem(id: '2', name: 'Item 2', price: 15.0, quantity: 1),
      ]);
      
      expect(state.totalPrice, 35.0); // (10 * 2) + (15 * 1) = 35.0
    });

    test('calculates item count correctly', () {
      final state = CartState(items: [
        CartItem(id: '1', name: 'Item 1', price: 10.0, quantity: 2),
        CartItem(id: '2', name: 'Item 2', price: 15.0, quantity: 3),
      ]);
      
      expect(state.itemCount, 5); // 2 + 3 = 5
    });
  });
}
