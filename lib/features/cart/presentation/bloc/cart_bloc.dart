import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/cart/domain/models/cart_item.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_event.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(items: [])) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItem>(_onUpdateCartItem);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    final itemIndex = currentItems.indexWhere((item) => item.id == event.item.id);

    if (itemIndex >= 0) {
      // Item exists, update quantity
      currentItems[itemIndex] = currentItems[itemIndex].copyWith(
        quantity: currentItems[itemIndex].quantity + 1,
      );
    } else {
      // Add new item
      currentItems.add(event.item);
    }

    emit(state.copyWith(items: currentItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.removeWhere((item) => item.id == event.itemId);
    emit(state.copyWith(items: currentItems));
  }

  void _onUpdateCartItem(UpdateCartItem event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    final itemIndex = currentItems.indexWhere((item) => item.id == event.item.id);
    
    if (itemIndex >= 0) {
      currentItems[itemIndex] = event.item;
      emit(state.copyWith(items: currentItems));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartState(items: []));
  }

  void clearCart() {
    add(ClearCart());
  }

  double getTotal() {
    return state.items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}
