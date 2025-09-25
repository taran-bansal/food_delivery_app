class CartItem {
  final String id;
  final String name;
  final String? description;
  final double price;
  final int quantity;
  final String? image;
  final List<String>? addons;

  CartItem({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.quantity = 1,
    this.image,
    this.addons,
  });

  CartItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? quantity,
    String? image,
    List<String>? addons,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      addons: addons ?? this.addons,
    );
  }
}
