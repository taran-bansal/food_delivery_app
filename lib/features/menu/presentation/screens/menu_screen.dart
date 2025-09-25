import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:food_delivery/core/theme/app_theme.dart';
import 'package:food_delivery/core/widgets/custom_text.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:food_delivery/features/cart/domain/models/cart_item.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_event.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_state.dart';

class MenuScreen extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  
  const MenuScreen({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedCategoryIndex = 0;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Simulate loading data
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  // Show cart button in app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(widget.restaurantName),
      centerTitle: true,
      actions: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            final itemCount = cartState.items.fold<int>(
              0,
              (sum, item) => sum + item.quantity,
            );

            if (itemCount == 0) {
              return const SizedBox.shrink();
            }

            return Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => _showCartBottomSheet(context),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      itemCount > 9 ? '9+' : '$itemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showCartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildCartBottomSheet(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 20),
              const Text('Failed to load menu. Please try again.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _hasError = false;
                    _isLoading = true;
                  });
                  Future.delayed(const Duration(seconds: 1), () {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  });
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return BlocProvider(
      create: (context) => CartBloc(),
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: _buildAppBar(),
          body: CustomScrollView(
            slivers: [
          // App Bar with restaurant info
          SliverAppBar(
            expandedHeight: 250.h,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Burger King'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Restaurant cover image
                  Image.asset(
                    'assets/images/burger_king.png',
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Restaurant info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Restaurant logo
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/burger_king_logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Restaurant details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              'Burger King',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                const CustomText('4.5', fontSize: 14),
                                const SizedBox(width: 8),
                                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                CustomText('20-30 min', fontSize: 14, color: Colors.grey[600]),
                              ],
                            ),
                            const SizedBox(height: 4),
                            CustomText('American • Fast Food • Burgers', 
                              fontSize: 14, 
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search in menu',
                              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Categories
          // Categories
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedCategoryIndex;
                  final categories = ['Burgers', 'Meals', 'Drinks', 'Desserts', 'Sides'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                      // Here you would typically filter menu items by category
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected ? null : Border.all(color: Colors.grey[300]!),
                        ),
                        child: Center(
                          child: CustomText(
                            categories[index],
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Menu items
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final menuItems = [
                    {
                      'name': 'Whopper',
                      'description': 'Flame-grilled beef patty with tomatoes, lettuce, mayo, ketchup, pickles, and onions on a sesame seed bun.',
                      'price': '\$5.99',
                      'image': 'assets/images/whopper.png',
                    },
                    {
                      'name': 'Cheeseburger',
                      'description': 'Flame-grilled beef patty with American cheese, ketchup, and pickles on a toasted bun.',
                      'price': '\$2.99',
                      'image': 'assets/images/cheeseburger.png',
                    },
                    {
                      'name': 'Chicken Fries',
                      'description': 'Crispy, golden-brown chicken fries, made with white meat chicken, seasoned with savory spices and herbs.',
                      'price': '\$3.49',
                      'image': 'assets/images/chicken_fries.png',
                    },
                  ];
                  
                  if (index >= menuItems.length) return null;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Food image with loading and error states
                        Stack(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(12),
                                ),
                                color: Colors.grey[200],
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(12),
                                ),
                                child: _buildImageWithLoading(menuItems[index]['image'] as String),
                              ),
                            ),
                          ],
                        ),
                        
                        // Food details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        menuItems[index]['name'] as String,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    CustomText(
                                      menuItems[index]['price'] as String,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                CustomText(
                                  menuItems[index]['description'] as String,
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 12),
                                // Add to cart button
                                BlocBuilder<CartBloc, CartState>(
                                  builder: (context, cartState) {
                                    final cartItem = cartState.items.firstWhere(
                                      (item) => item.id == '${menuItems[index]['name']}_$index',
                                      orElse: () => CartItem(
                                        id: '',
                                        name: '',
                                        price: 0,
                                        image: '',
                                      ),
                                    );
                                    final isInCart = cartItem.id.isNotEmpty;

                                    if (isInCart) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove_circle_outline, size: 20),
                                            onPressed: () => context.read<CartBloc>().add(RemoveFromCart(cartItem.id)),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text('${cartItem.quantity}'),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle_outline, size: 20, color: AppTheme.primaryColor),
                                            onPressed: () => context.read<CartBloc>().add(AddToCart(CartItem(
                                              id: cartItem.id,
                                              name: cartItem.name,
                                              price: cartItem.price,
                                              image: cartItem.image,
                                              quantity: 1,
                                            ))),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                          ),
                                        ],
                                      );
                                    }

                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<CartBloc>().add(AddToCart(CartItem(
                                            id: '${menuItems[index]['name']}_$index',
                                            name: menuItems[index]['name'] as String,
                                            price: double.parse((menuItems[index]['price'] as String).replaceAll(r'\$', '')),
                                            image: menuItems[index]['image'] as String,
                                          )));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: AppTheme.primaryColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: const CustomText(
                                            'ADD',
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      
      // Bottom cart summary
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.items.isEmpty) return const SizedBox.shrink();
        
        final itemCount = state.items.fold<int>(0, (sum, item) => sum + item.quantity);
        
        return FloatingActionButton.extended(
          onPressed: () => _showCartBottomSheet(context),
          label: Text('View Cart ($itemCount)'),
          icon: const Icon(Icons.shopping_cart),
        );
      },
    );
  }

  Widget _buildCartBottomSheet(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        final totalAmount = cartState.items.fold<double>(
          0,
          (sum, item) => sum + (item.price * item.quantity),
        );

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          minChildSize: 0.25,
          builder: (_, controller) => Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Text(
                  'Your Order',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: cartState.items.isEmpty
                      ? const Center(child: Text('Your cart is empty'))
                      : ListView.builder(
                          controller: controller,
                          itemCount: cartState.items.length,
                          itemBuilder: (context, index) {
                            final item = cartState.items[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: item.image != null 
                                    ? AssetImage(item.image!)
                                    : null,
                                onBackgroundImageError: (_, __) {
                                  // Handle image loading error
                                },
                                child: item.image == null ? const Icon(Icons.fastfood) : null,
                              ),
                              title: Text(item.name),
                              subtitle: Text('\$${item.price.toStringAsFixed(2)} x ${item.quantity}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      if (item.quantity > 1) {
                                        context.read<CartBloc>().add(UpdateCartItem(item.copyWith(quantity: item.quantity - 1)));
                                      } else {
                                        context.read<CartBloc>().add(RemoveFromCart(item.id));
                                      }
                                    },
                                  ),
                                  Text('${item.quantity}'),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline, color: AppTheme.primaryColor),
                                    onPressed: () => context.read<CartBloc>().add(AddToCart(CartItem(
                                      id: item.id,
                                      name: item.name,
                                      price: item.price,
                                      image: item.image,
                                      quantity: 1,
                                    ))),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (cartState.items.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                        context.push('/checkout');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeFromCart(String itemId, BuildContext context) {
    context.read<CartBloc>().add(RemoveFromCart(itemId));
  }
  
  Widget _buildCartItemsList(List<CartItem> cartItems, double totalAmount, BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            const Text(
              'Your Order',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Cart items list
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Dismissible(
                    key: Key(item.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      // Remove item from cart
                      _removeFromCart(item.id, context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.name} removed from cart')),
                      );
                    },
                    child: ListTile(
                      leading: Image.asset(
                        item.image ?? 'assets/images/default_food.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood),
                      ),
                      title: Text(item.name),
                      subtitle: Text('\$${item.price.toStringAsFixed(2)} each'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, size: 20),
                            onPressed: () => context.read<CartBloc>().add(RemoveFromCart(item.id)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('${item.quantity}'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, size: 20, color: AppTheme.primaryColor),
                            onPressed: () => context.read<CartBloc>().add(AddToCart(
                              CartItem(
                                id: item.id,
                                name: item.name,
                                price: item.price,
                                image: item.image,
                              ),
                            )),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Total and checkout button
            Column(
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final cartBloc = context.read<CartBloc>();
                      final cartItems = cartBloc.state;
                      
                      if (cartItems.items.isEmpty) {
                        Navigator.pop(context); // Close the bottom sheet
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Your cart is empty')),
                        );
                        return;
                      }
                      
                      Navigator.pop(context); // Close the bottom sheet
                      context.push(
                        '/checkout',
                        extra: {
                          'restaurantName': widget.restaurantName,
                          'cartItems': cartItems,
                          'totalAmount': cartItems.items.fold(
                            0.0,
                            (sum, item) => sum + item.price * item.quantity,
                          ),
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildImageWithLoading(String imagePath) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => const Center(
        child: Icon(Icons.fastfood, color: Colors.grey),
      ),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return child;
      },
    );
  }

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }
}

