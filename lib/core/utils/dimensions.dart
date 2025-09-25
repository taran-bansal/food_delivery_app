import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimensions {
  // Padding and margin sizes
  static const double paddingXXS = 2.0;
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  
  // Icon sizes
  static const double iconSizeXS = 12.0;
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
  
  // Button sizes
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;
  
  // Input field
  static const double inputFieldHeight = 48.0;
  static const double inputFieldRadius = 12.0;
  
  // Card
  static const double cardRadius = 16.0;
  static const double cardElevation = 2.0;
  
  // App bar
  static const double appBarHeight = 56.0;
  
  // Bottom navigation bar
  static const double bottomNavBarHeight = 56.0;
  
  // Get responsive dimensions
  static double get responsivePaddingXXS => paddingXXS.w;
  static double get responsivePaddingXS => paddingXS.w;
  static double get responsivePaddingS => paddingS.w;
  static double get responsivePaddingM => paddingM.w;
  static double get responsivePaddingL => paddingL.w;
  static double get responsivePaddingXL => paddingXL.w;
  static double get responsivePaddingXXL => paddingXXL.w;
  
  static double get responsiveRadiusXS => radiusXS.r;
  static double get responsiveRadiusS => radiusS.r;
  static double get responsiveRadiusM => radiusM.r;
  static double get responsiveRadiusL => radiusL.r;
  static double get responsiveRadiusXL => radiusXL.r;
  static double get responsiveRadiusXXL => radiusXXL.r;
  
  static double get responsiveIconSizeXS => iconSizeXS.sp;
  static double get responsiveIconSizeS => iconSizeS.sp;
  static double get responsiveIconSizeM => iconSizeM.sp;
  static double get responsiveIconSizeL => iconSizeL.sp;
  static double get responsiveIconSizeXL => iconSizeXL.sp;
  
  // Responsive edge insets
  static EdgeInsets get paddingAllXXS => EdgeInsets.all(responsivePaddingXXS);
  static EdgeInsets get paddingAllXS => EdgeInsets.all(responsivePaddingXS);
  static EdgeInsets get paddingAllS => EdgeInsets.all(responsivePaddingS);
  static EdgeInsets get paddingAllM => EdgeInsets.all(responsivePaddingM);
  static EdgeInsets get paddingAllL => EdgeInsets.all(responsivePaddingL);
  static EdgeInsets get paddingAllXL => EdgeInsets.all(responsivePaddingXL);
  
  static EdgeInsets get paddingHorizontalXXS => EdgeInsets.symmetric(horizontal: responsivePaddingXXS);
  static EdgeInsets get paddingHorizontalXS => EdgeInsets.symmetric(horizontal: responsivePaddingXS);
  static EdgeInsets get paddingHorizontalS => EdgeInsets.symmetric(horizontal: responsivePaddingS);
  static EdgeInsets get paddingHorizontalM => EdgeInsets.symmetric(horizontal: responsivePaddingM);
  static EdgeInsets get paddingHorizontalL => EdgeInsets.symmetric(horizontal: responsivePaddingL);
  static EdgeInsets get paddingHorizontalXL => EdgeInsets.symmetric(horizontal: responsivePaddingXL);
  
  static EdgeInsets get paddingVerticalXXS => EdgeInsets.symmetric(vertical: responsivePaddingXXS);
  static EdgeInsets get paddingVerticalXS => EdgeInsets.symmetric(vertical: responsivePaddingXS);
  static EdgeInsets get paddingVerticalS => EdgeInsets.symmetric(vertical: responsivePaddingS);
  static EdgeInsets get paddingVerticalM => EdgeInsets.symmetric(vertical: responsivePaddingM);
  static EdgeInsets get paddingVerticalL => EdgeInsets.symmetric(vertical: responsivePaddingL);
  static EdgeInsets get paddingVerticalXL => EdgeInsets.symmetric(vertical: responsivePaddingXL);
  
  // Responsive border radius
  static BorderRadius get borderRadiusXS => BorderRadius.circular(responsiveRadiusXS);
  static BorderRadius get borderRadiusS => BorderRadius.circular(responsiveRadiusS);
  static BorderRadius get borderRadiusM => BorderRadius.circular(responsiveRadiusM);
  static BorderRadius get borderRadiusL => BorderRadius.circular(responsiveRadiusL);
  static BorderRadius get borderRadiusXL => BorderRadius.circular(responsiveRadiusXL);
  static BorderRadius get borderRadiusXXL => BorderRadius.circular(responsiveRadiusXXL);
  
  // Responsive button sizes
  static Size get buttonSizeS => Size.fromHeight(buttonHeightS.h);
  static Size get buttonSizeM => Size.fromHeight(buttonHeightM.h);
  static Size get buttonSizeL => Size.fromHeight(buttonHeightL.h);
  
  // Responsive input field height
  static double get responsiveInputFieldHeight => inputFieldHeight.h;
  
  // Responsive app bar height
  static double get responsiveAppBarHeight => appBarHeight.h;
  
  // Responsive bottom navigation bar height
  static double get responsiveBottomNavBarHeight => bottomNavBarHeight.h;
  
  // Screen size helpers
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  
  // Responsive screen size helpers
  static double responsiveScreenWidth(BuildContext context, double percentage) => 
      screenWidth(context) * percentage;
      
  static double responsiveScreenHeight(BuildContext context, double percentage) => 
      screenHeight(context) * percentage;
}
