import 'package:food_delivery/features/cart/domain/models/cart_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartItem', () {
    final testItem = CartItem(
      id: '1',
      name: 'Test Item',
      price: 9.99,
      quantity: 1,
      description: 'Test Description',
      image: 'test_image.png',
      addons: ['Extra Cheese', 'Spicy'],
    );

    test('should create a valid CartItem', () {
      expect(testItem.id, '1');
      expect(testItem.name, 'Test Item');
      expect(testItem.price, 9.99);
      expect(testItem.quantity, 1);
      expect(testItem.description, 'Test Description');
      expect(testItem.image, 'test_image.png');
      expect(testItem.addons, ['Extra Cheese', 'Spicy']);
    });

    test('should create a copy with updated fields', () {
      final updatedItem = testItem.copyWith(
        quantity: 2,
        price: 10.99,
        addons: ['Extra Cheese'],
      );

      expect(updatedItem.id, '1');
      expect(updatedItem.name, 'Test Item');
      expect(updatedItem.price, 10.99);
      expect(updatedItem.quantity, 2);
      expect(updatedItem.addons, ['Extra Cheese']);
    });

    test('should have correct equality', () {
      final item1 = CartItem(
        id: '1',
        name: 'Item',
        price: 10.0,
        quantity: 1,
      );
      
      final item2 = CartItem(
        id: '1',
        name: 'Item',
        price: 10.0,
        quantity: 1,
      );
      
      final item3 = CartItem(
        id: '2',
        name: 'Item',
        price: 10.0,
        quantity: 1,
      );

      expect(item1, item2);
      expect(item1, isNot(equals(item3)));
    });
  });
}
