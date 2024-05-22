import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/theme/style.dart';

import 'color.dart';

const fontFamily = "cairo";

class AppTheme {
  static final lightTheme = ThemeData(
    textTheme: textLightTheme,
    inputDecorationTheme: inputDecorationThemeLight,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(primary: AppColors.primary),
    checkboxTheme: checkBoxTheme,
    iconButtonTheme : IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: AppColors.primary)
    ),
    brightness: Brightness.light,
    fontFamily: fontFamily,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlineButtonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
    appBarTheme: AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(size: 22.r,color: AppColors.secondary),
      titleTextStyle: TextStyle(fontSize: 16.sp,color: AppColors.secondary)
    ),
    cardTheme: cardTheme,
    dialogTheme: dialogTheme,
    iconTheme: iconTheme,
  );

  static TextTheme textLightTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 24.sp, fontFamily: fontFamily),
    displayMedium: TextStyle(fontSize: 22.sp, fontFamily: fontFamily, color: AppColors.primary),
    displaySmall: TextStyle(fontSize: 18.sp, fontFamily: fontFamily),
    headlineLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    headlineMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    headlineSmall: TextStyle(fontSize: 14.sp, fontFamily: fontFamily),
    bodyLarge: TextStyle(fontSize: 12.sp,color: const Color(0xFF767982), fontFamily: fontFamily, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 11.sp, fontFamily: fontFamily),
    bodySmall: TextStyle(fontSize: 11.sp, fontFamily: fontFamily),
    titleSmall: TextStyle(fontSize: 11.sp, fontFamily: fontFamily, color: AppColors.primary),
    titleMedium: TextStyle(fontSize: 12.sp, fontFamily: fontFamily, color: AppColors.primary),
    titleLarge:
        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, fontFamily: fontFamily, color: AppColors.primary),
    labelLarge:
        TextStyle(fontSize: 12.sp, fontFamily: fontFamily, color: Colors.grey[500], fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontSize: 12.sp, fontFamily: fontFamily, color: Colors.grey[500]),
    labelSmall: TextStyle(fontSize: 11.sp, fontFamily: fontFamily, color: Colors.grey[500]),
  );
}
