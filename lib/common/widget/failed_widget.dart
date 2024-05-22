
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';



class FailedWidget extends StatelessWidget {
  const FailedWidget({
    super.key,
    required this.error,
    this.onPressed,
  });

  final String error;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                error,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.r,),
              SizedBox(
                width: 118.w,
                child: ElevatedButton(
                  onPressed: onPressed,

                  child: const Text("Retry"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
