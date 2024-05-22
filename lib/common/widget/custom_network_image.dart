import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color.dart';


class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.radius,
    this.isCircle = false,
    this.showLoading = true,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String imageUrl;
  final BoxFit fit;
  final bool isCircle;
  final bool showLoading;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          color: AppColors.secondary,
          borderRadius: radius == null ? null : BorderRadius.circular(radius!)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        filterQuality: FilterQuality.high,
        placeholder: (context, url) => showLoading ?  SizedBox(
          height: 35.r,
          width: 35.r,
          child: const AspectRatio(
            aspectRatio: 1,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ),
            ),
          ),
        ) : const SizedBox(),
        errorWidget: (context, url, error) => const FlutterLogo(),
        fit: fit,
      ),
    );
  }
}
