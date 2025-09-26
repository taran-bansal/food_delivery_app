import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_event.dart';
import 'package:go_router/go_router.dart';
import 'package:food_delivery/core/theme/app_theme.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart' as cart_bloc;
import 'package:food_delivery/core/widgets/custom_text.dart';
import 'package:food_delivery/features/cart/domain/models/cart_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentMethod = 0;
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'icon': Icons.credit_card,
      'title': 'Credit / Debit Card',
      'subtitle': 'Pay with your card',
    },
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Wallet',
      'subtitle': 'Use your wallet balance',
    },
    {
      'icon': Icons.money,
      'title': 'Cash on Delivery',
      'subtitle': 'Pay when you receive',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<cart_bloc.CartBloc>();
    final cartItems = cartBloc.state.items;
    final totalAmount = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    final deliveryFee = 2.99;
    final total = totalAmount + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.go('/cart'),
        ),
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Address Section
                  _buildSectionHeader('Delivery Address'),
                  SizedBox(height: 8.h),
                  _buildAddressCard(),
                  
                  SizedBox(height: 24.h),
                  
                  // Payment Method Section
                  _buildSectionHeader('Payment Method'),
                  SizedBox(height: 8.h),
                  _buildPaymentMethods(),
                  
                  SizedBox(height: 24.h),
                  
                  // Order Summary Section
                  _buildSectionHeader('Order Summary'),
                  SizedBox(height: 8.h),
                  _buildOrderSummary(cartItems, totalAmount, deliveryFee, total),
                  
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
          
          // Fixed bottom button
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'Total:',
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                        CustomText(
                          '\$${total.toStringAsFixed(2)}',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: ElevatedButton(
                      onPressed: () => _showOrderConfirmation(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: CustomText(
        title,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAddressCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on_outlined,
                color: AppTheme.primaryColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        'John Doe',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Handle change address
                        },
                        child: CustomText(
                          'Change',
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    '123 Main St, Apt 4B',
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  CustomText(
                    'New York, NY 10001',
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _paymentMethods.length,
        separatorBuilder: (_, __) => Divider(height: 1.h, indent: 16.w, endIndent: 16.w),
        itemBuilder: (context, index) {
          final method = _paymentMethods[index];
          return _buildPaymentMethod(
            icon: method['icon'] as IconData,
            title: method['title'] as String,
            subtitle: method['subtitle'] as String,
            isSelected: _selectedPaymentMethod == index,
            onTap: () => setState(() => _selectedPaymentMethod = index),
          );
        },
      ),
    );
  }

  Widget _buildPaymentMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      leading: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? AppTheme.primaryColor : Colors.grey[600],
          size: 22.sp,
        ),
      ),
      title: CustomText(
        title,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      subtitle: CustomText(
        subtitle,
        fontSize: 13.sp,
        color: Colors.grey[600],
      ),
      trailing: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey[400]!,
            width: 2,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            : null,
      ),
      onTap: onTap,
    );
  }

  Widget _buildOrderSummary(
    List<CartItem> items,
    double subtotal,
    double deliveryFee,
    double total,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final item = items[index];
                return Row(
                  children: [
                    // Item image
                    if (item.image != null) ...[
                      Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey[100],
                          image: DecorationImage(
                            image: AssetImage(item.image!), 
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                    // Item details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            item.name,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          CustomText(
                            '\$${item.price.toStringAsFixed(2)} x ${item.quantity}',
                            fontSize: 13.sp,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                    // Item total
                    CustomText(
                      '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                );
              },
            ),
            
            SizedBox(height: 16.h),
            
            // Price breakdown
            _buildSummaryRow('Subtotal', subtotal),
            SizedBox(height: 8.h),
            _buildSummaryRow('Delivery Fee', deliveryFee),
            SizedBox(height: 12.h),
            const Divider(),
            SizedBox(height: 12.h),
            _buildSummaryRow('Total', total, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label,
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? null : Colors.grey[600],
          ),
          CustomText(
            '\$${amount.toStringAsFixed(2)}',
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppTheme.primaryColor : null,
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

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 32.sp,
                  color: AppTheme.primaryColor,
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Title
              CustomText(
                'Confirm Order',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 8.h),
              
              // Message
              CustomText(
                'Are you sure you want to place this order?',
                fontSize: 14.sp,
                color: Colors.grey[600],
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 24.h),
              
              // Buttons
              Row(
                children: [
                  // Cancel button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 12.w),
                  
                  // Confirm button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                        
                        // Generate a random order ID
                        final orderId = 'OD${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
                        
                        // Navigate to order confirmation screen using GoRouter
                        GoRouter.of(context).go(
                          '/order-confirmation?orderId=$orderId&total=$totalAmount',
                        );
                        
                        // Clear the cart after a short delay to allow the user to see the order details
                        Future.delayed(const Duration(milliseconds: 500), () {
                          cartBloc.add(const ClearCart());
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'CONFIRM',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
