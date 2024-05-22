

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, this.isError = false});

  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const FlutterLogo()
          ],
        ),
      ),
    );
  }
}
