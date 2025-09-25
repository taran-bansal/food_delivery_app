import 'package:equatable/equatable.dart';
import 'package:food_delivery/features/cart/domain/models/cart_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final CartItem item;

  const AddToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final String itemId;

  const RemoveFromCart(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class UpdateCartItem extends CartEvent {
  final CartItem item;

  const UpdateCartItem(this.item);

  @override
  List<Object> get props => [item];
}

class ClearCart extends CartEvent {
  const ClearCart();
}
