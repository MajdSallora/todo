import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/common/utils/extensions/context_extension.dart';
import 'package:todo/generated/assets.dart';
import '../../../../../common/theme/color.dart';
import '../../../../../common/utils/custom_loading.dart';
import '../../../../../common/widget/custom_reative_failed.dart';
import '../../../../../injection/injection.dart';
import '../../../../root/presentation/ui/screen/root.dart';
import '../../state/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final AuthBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = getIt<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Builder(builder: (context) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.signInState.isSuccess()) {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RootScreen()));
            }
            if (state.signInState.isLoading()) {
              CustomLoading.showLoading();
            } else {
              CustomLoading.closeAllLoading();
            }
            if(state.signInState.isFail()){
              toastification.dismissAll(delayForAnimation: false);
              toastification.show(
                type: ToastificationType.error,
                title: Text(state.signInState.error ?? "Error"),
                style: ToastificationStyle.fillColored,
                autoCloseDuration: const Duration(seconds: 5),
              );
            }
          },
          child: ReactiveForm(
            formGroup: context
                .read<AuthBloc>()
                .formSignIn,
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.imagesLogo,width: 200.r,height: 200.r,),
                        SizedBox(
                          height: 28.r,
                        ),
                        Text(
                          "Login",
                          style: context.textTheme.displaySmall!
                              .copyWith(color: AppColors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 28.r,
                        ),
                        SizedBox(
                          height: 28.r,
                        ),
                        CustomReactiveField(
                          controller: AuthBloc.username,
                          hintText: "Username",
                        ),
                        CustomReactiveField(
                          controller: AuthBloc.password,
                          hintText: "Password",
                          isPassword: true,
                          suffixPassIcon: const Icon(
                            Icons.visibility_off,
                            color: Color(0xFF767982),
                          ),
                          asset: const Icon(
                            Icons.visibility,
                            color: Color(0xFF767982),
                          ),
                        ),
                        SizedBox(
                          height: 16.r,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(Login());
                              },
                              child: const Text("Login")),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
