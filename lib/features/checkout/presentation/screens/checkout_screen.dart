import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:food_delivery/core/theme/app_theme.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart' as cart_bloc;

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<cart_bloc.CartBloc>();
    final cartItems = cartBloc.state.items;
    final totalAmount = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address Section
            _buildSectionHeader('Delivery Address'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '123 Main St, Apt 4B',
                      style: TextStyle(fontSize: 14),
                    ),
                    const Text(
                      'New York, NY 10001',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        // Handle change address
                      },
                      child: const Text('Change Address'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Payment Method Section
            _buildSectionHeader('Payment Method'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildPaymentMethod(
                      icon: Icons.credit_card,
                      title: 'Credit / Debit Card',
                      isSelected: true,
                    ),
                    const Divider(),
                    _buildPaymentMethod(
                      icon: Icons.account_balance_wallet,
                      title: 'Wallet',
                      isSelected: false,
                    ),
                    const Divider(),
                    _buildPaymentMethod(
                      icon: Icons.money,
                      title: 'Cash on Delivery',
                      isSelected: false,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Order Summary Section
            _buildSectionHeader('Order Summary'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.name} x${item.quantity}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    _buildSummaryRow('Subtotal', totalAmount),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Delivery Fee', 2.99),
                    const Divider(),
                    _buildSummaryRow(
                      'Total',
                      totalAmount + 2.99,
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Place Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle place order
                  _showOrderConfirmation(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required IconData icon,
    required String title,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.primaryColor : Colors.grey,
      ),
      title: Text(title),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: AppTheme.primaryColor,
            )
          : null,
      onTap: () {
        // Handle payment method selection
      },
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppTheme.primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmation(BuildContext context) {
    final cartBloc = context.read<cart_bloc.CartBloc>();
    final cartItems = cartBloc.state.items;
    final totalAmount = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    
    // Generate a random order ID
    final orderId = 'OD${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
    
    // Navigate to order confirmation screen using GoRouter
    GoRouter.of(context).go(
      '/order-confirmation?orderId=$orderId&total=$totalAmount',
    );
    
    // Clear the cart after a short delay to allow the user to see the order details
    Future.delayed(const Duration(milliseconds: 500), () {
      cartBloc.clearCart();
    });
  }
}
