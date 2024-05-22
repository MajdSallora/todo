import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../theme/color.dart';

class CustomReactiveField extends StatelessWidget {
  CustomReactiveField({
    Key? key,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    required this.controller,
    this.initialValue,
    this.isExpend = false,
    this.onSuffixTap,
    this.maxLines = 1,
    this.onPrefixTap,
    this.height,
    this.width,
    this.onChanged,
    this.assetPrefix,
    this.asset,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.borderAlwaysEnable = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.isPassword = false,
    this.title,
    this.onTap,
    this.fill = true,
    this.titleColor,
    this.suffixPassIcon,
    this.fillColor,
    this.fieldPadding,
    this.assetPadding,
    this.prefixPadding,
    this.suffixPadding,
    this.padding = const EdgeInsets.only(bottom: 16),
    this.onSubmitted,
  }) : super(key: key);
  final String? hintText;
  final Object? asset;
  final Object? assetPrefix;
  final String? initialValue;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String controller;
  final int maxLines;
  final double? height;
  final bool isExpend;
  final VoidCallback? onSuffixTap;
  final BorderRadius borderRadius;
  final VoidCallback? onPrefixTap;
  final Function(FormControl<dynamic>)? onChanged;
  final double? width;
  final bool borderAlwaysEnable;
  final bool readOnly;
  final ReactiveFormFieldCallback? onTap;
  final String? title;
  final Color? titleColor;
  final Color? fillColor;
  final bool fill;
  final Object? suffixPassIcon;
  bool isPassword;
  final EdgeInsets? fieldPadding;
  final EdgeInsets? assetPadding;
  final EdgeInsets? prefixPadding;
  final EdgeInsets? suffixPadding;
  final EdgeInsets padding;

  final void Function(FormControl<dynamic>)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    bool hidden = false;
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.r),
                    child: Text(
                      title!,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: titleColor),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: title != null ? 8.h : 0,
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 12),
                    color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                    blurRadius: 16,
                    spreadRadius: 0.02)
              ]),
              child: ReactiveTextField(
                formControlName: controller,
                maxLines: isExpend ? null : maxLines,
                minLines: isExpend ? null : maxLines,
                expands: isExpend,
                readOnly: readOnly,
                onTap: onTap,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                onSubmitted: onSubmitted,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  filled: fill,
                  fillColor: fillColor,
                  border: Theme.of(context).inputDecorationTheme.border,
                  contentPadding: fieldPadding ?? REdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  enabledBorder: borderAlwaysEnable
                      ? OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.primary), borderRadius: borderRadius)
                      : Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: borderRadius),
                  prefixIcon: assetPrefix != null
                      ? GestureDetector(
                          onTap: onPrefixTap,
                          child: Padding(
                            padding: prefixPadding ?? EdgeInsets.symmetric(horizontal: 26.r, vertical: 6.r),
                            child: assetPrefix is String
                                ? SvgPicture.asset(assetPrefix!.toString())
                                : assetPrefix! as Widget,
                          ),
                        )
                      : null,
                  suffixIcon: asset != null
                      ? GestureDetector(
                          onTap: suffixPassIcon != null
                              ? () {
                                  setState(() {
                                    hidden = !hidden;
                                    isPassword = !isPassword;
                                  });
                                }
                              : onSuffixTap,
                          child: Padding(
                            padding: assetPadding ?? const EdgeInsets.symmetric(horizontal: 22),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedCrossFade(
                                  alignment: Alignment.centerRight,
                                  firstChild: asset is String ? SvgPicture.asset(asset!.toString()) : asset! as Widget,
                                  secondChild: suffixPassIcon is String
                                      ? SvgPicture.asset(suffixPassIcon!.toString())
                                      : suffixPassIcon! as Widget,
                                  crossFadeState: hidden ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                  duration: const Duration(milliseconds: 400),
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                ),
                obscureText: isPassword,
              ),
            ),
          ],
        ),
      );
    });
  }
}
