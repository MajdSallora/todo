import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/app/auth/infrustructure/model/auth.dart';
import 'package:todo/app/root/presentation/ui/screen/root.dart';
import 'package:todo/main.dart';
import '../common/theme/style.dart';
import '../common/theme/theme.dart';
import '../common/widget/splash_screen.dart';
import '../injection/injection.dart';
import 'auth/presentation/ui/screen/sign_in.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return ScreenUtilInit(
        ensureScreenSize: true,
        designSize: orientation == Orientation.portrait ? designSize : designSizeOrientation,
        builder: (context, _) {
          return Builder(builder: (context) {
            return ToastificationWrapper(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                home: User.getToken() == null ? const SignInScreen() : RootScreen(),
                builder: (context, child) {
                  child = BotToastInit()(context, child);
                  return child;
                },
              ),
            );
          });
        },
      );
    });
  }


}
