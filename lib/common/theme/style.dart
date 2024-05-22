import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color.dart';

///constant
double horizontalAppPadding = 32.w;
double kIconSize = 24.r;

const String fontFamily = "cairo";

const designSize = Size(375, 812);
const designSizeOrientation = Size(812, 375);

///Style
EdgeInsets buttonRPadding = EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r);

BorderRadius borderRadiusCircular = BorderRadius.circular(12);

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  elevation: 2,
  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
  shadowColor: Colors.transparent,
  backgroundColor: AppColors.primary,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(borderRadius: borderRadiusCircular),
);



final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
  side: const BorderSide(color: AppColors.primary),
  // textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, fontFamily: fontFamily),
  shape: RoundedRectangleBorder(borderRadius: borderRadiusCircular),
);



final InputDecorationTheme inputDecorationThemeLight = InputDecorationTheme(
    fillColor: AppColors.lightGrey,
    iconColor: AppColors.secondary,
    prefixIconColor: AppColors.secondary,
    suffixIconColor: AppColors.secondary,
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    contentPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 16.r),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none));

final dialogTheme = DialogTheme(
  shape: RoundedRectangleBorder(
    borderRadius: borderRadiusCircular,
  ),
);

final cardTheme = CardTheme(
  elevation: 1,
  margin: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
);


final iconTheme = IconThemeData(
  size: kIconSize.r,
  color: AppColors.secondary,
);

final checkBoxTheme = CheckboxThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
  side: const BorderSide(),
);

InputDecoration dynamicInputDecorationTheme({
  required ThemeData themeData,
  required String labelText,
  required IconData icon,
  String? hintText,
}) =>
    InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon),
        errorStyle: themeData.textTheme.labelMedium!.copyWith(color: AppColors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.r),
        focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: borderRadiusCircular),
        errorBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: borderRadiusCircular),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: borderRadiusCircular),
        border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: borderRadiusCircular),
        prefixIconConstraints: BoxConstraints(minWidth: 40.w));

final InputDecorationTheme inputDecorationThemeDark = InputDecorationTheme(
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.primary),
    borderRadius: borderRadiusCircular,
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
  border: OutlineInputBorder(borderRadius: borderRadiusCircular),
);
