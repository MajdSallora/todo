import 'dart:core';

import 'package:equatable/equatable.dart';

enum _Status { initial, loading, success, fail, none }

class BlocStatus extends Equatable{
  final _Status status;

  const BlocStatus._({this.status = _Status.initial})
      : error = null,
        data = null;
  final String? error;
  final String? data;

  const BlocStatus.loading()
      : status = _Status.loading,
        error = null,
        data = null;

  const BlocStatus.success({this.data})
      : status = _Status.success,
        error = null;

  const BlocStatus.fail({required this.error})
      : status = _Status.fail,
        data = null;

  const BlocStatus.initial()
      : status = _Status.initial,
        error = null,
        data = null;

  bool isLoading() => status == _Status.loading;

  bool isInitial() => status == _Status.initial;

  bool isFail() => status == _Status.fail;

  bool isSuccess() => status == _Status.success;

  @override
  // TODO: implement props
  List<Object?> get props => [status,error];
}
