import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import '../../../../common/constant/keys.dart';
import '../../../../common/utils/bloc_status.dart';
import '../../../../common/utils/custom_loading.dart';
import '../../../../injection/injection.dart';
import '../../application/facade_auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FacadeAuth _facade;

  AuthBloc({required FacadeAuth facade})
      : _facade = facade,
        super(const AuthState()) {
    on<AuthEvent>((event, emit) async {
      if (event is Login) {
        await login(event, emit);
      }
    });
  }

  Future<void> login(Login event, Emitter emit) async {
    if (formSignIn.valid) {
      emit(state.copyWith(signInState: const BlocStatus.loading()));
      final result = await _facade.login(
          username: formSignIn.control(username).value,
          password: formSignIn.control(password).value);

      await result.fold<Future>((left) async {


        emit(state.copyWith(signInState: BlocStatus.fail(error: left)));
      }, (right) async {
        await getIt<SharedPreferences>()
            .setString(kUser, jsonEncode(right.toJson()));
        emit(state.copyWith(signInState: const BlocStatus.success()));
      });
    } else {
      formSignIn.markAllAsTouched();
    }
  }

  final formSignIn = FormGroup({
    username: FormControl<String>(
        value: "kminchelle",
        validators:[
                Validators.required,
              ]),
    password: FormControl<String>(
        value: "0lelplR",
        validators: [Validators.required]),
  });

  //**************Sign In*********************
  static const String username = 'phone';
  static const String password = 'password';
}
