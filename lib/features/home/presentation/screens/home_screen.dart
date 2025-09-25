import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:food_delivery/core/theme/app_theme.dart';
import 'package:food_delivery/core/widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar with location and profile
                _buildAppBar(context),
                SizedBox(height: 24.h),
                
                // Search Bar
                _buildSearchBar(),
                SizedBox(height: 24.h),
                
                // Categories Section
                _buildCategoriesSection(),
                SizedBox(height: 24.h),
                
                // Popular Items Section
                _buildSectionTitle('Popular Items'),
                SizedBox(height: 16.h),
                _buildPopularItems(),
                
                // Nearby Restaurants Section
                SizedBox(height: 24.h),
                _buildSectionTitle('Nearby Restaurants'),
                SizedBox(height: 16.h),
                _buildNearbyRestaurants(),
                
                // Add some bottom padding
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText('Delivery to', fontSize: 14, color: Colors.grey[600]),
            Row(
              children: [
                CustomText('Home', fontSize: 16, fontWeight: FontWeight.w600),
                const Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ],
        ),
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: const Icon(Icons.person_outline, size: 24),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for food or restaurant',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [
      {'icon': Icons.fastfood, 'label': 'Burger'},
      {'icon': Icons.local_pizza, 'label': 'Pizza'},
      {'icon': Icons.ramen_dining, 'label': 'Noodles'},
      {'icon': Icons.icecream, 'label': 'Dessert'},
      {'icon': Icons.local_drink, 'label': 'Drinks'},
    ];

    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Column(
              children: [
                Container(
                  width: 70.w,
                  height: 70.w,
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
                  child: Icon(
                    categories[index]['icon'] as IconData,
                    size: 30,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomText(
                  categories[index]['label'] as String,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        CustomText(
          'See all',
          fontSize: 14,
          color: AppTheme.primaryColor,
        ),
      ],
    );
  }

  Widget _buildPopularItems() {
    final items = [
      {
        'name': 'Cheese Burger',
        'restaurant': 'Burger King',
        'price': '\$12.99',
        'image': 'assets/images/burger.png',
      },
      {
        'name': 'Pepperoni Pizza',
        'restaurant': 'Pizza Hut',
        'price': '\$14.99',
        'image': 'assets/images/pizza.png',
      },
    ];

    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: 160.w,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image container
                Container(
                  height: 120.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: AssetImage(items[index]['image'] as String),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index]['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index]['restaurant'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            items[index]['price'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add, 
                                color: Colors.white, 
                                size: 16,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNearbyRestaurants() {
    final restaurants = [
      {
        'id': '1',
        'name': 'Burger King',
        'cuisine': 'American, Fast Food',
        'rating': '4.5',
        'deliveryTime': '20-30 min',
        'image': 'assets/images/burger_king.png',
      },
      {
        'id': '2',
        'name': 'Pizza Hut',
        'cuisine': 'Italian, Pizza',
        'rating': '4.3',
        'deliveryTime': '25-35 min',
        'image': 'assets/images/pizza_hut.png',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.go(
              '/restaurant/${restaurants[index]['id']}',
              extra: {'name': restaurants[index]['name']},
            );
          },
          child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(16),
                  ),
                  color: Colors.grey[200],
                  // In a real app, use Image.network or Image.asset with actual images
                  image: DecorationImage(
                    image: AssetImage(restaurants[index]['image'] as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                              restaurants[index]['name'] as String,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              CustomText(
                                restaurants[index]['rating'] as String,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        restaurants[index]['cuisine'] as String,
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          CustomText(
                            restaurants[index]['deliveryTime'] as String,
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),);
      },
    );
  }
}
