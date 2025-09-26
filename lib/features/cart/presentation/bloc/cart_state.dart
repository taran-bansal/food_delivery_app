import 'package:equatable/equatable.dart';
import 'package:food_delivery/features/cart/domain/models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({
    required this.items,
  });

  double get totalPrice {
    return items.fold(
      0,
      (total, item) => total + (item.price * item.quantity),
    );
  }

  int get itemCount {
    return items.fold(0, (total, item) => total + item.quantity);
  }

  @override
  List<Object> get props => [items];

  CartState copyWith({
    List<CartItem>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }
}
