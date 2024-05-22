import 'package:flutter/material.dart';


import '../../common/widget/failed_widget.dart';
import '../../common/widget/loading_progress.dart';
import 'result.dart';

class ResultBuilder<T> extends StatelessWidget {
  ResultBuilder({
    Key? key,
    required this.success,
    this.loading,
    this.error,
    required this.onError,
    required this.result,
  }) : super(key: key);

  final Result<T> result;
  Widget Function()? loading;
  Widget? error;
  final Widget Function(T data) success;
  final Function() onError;

  @override
  Widget build(BuildContext context) {
    late final Widget next;

    loading ??= () => const LoadingProgress();

    result.when(
      init: () => next = const SizedBox(),
      loading: () => next = loading!(),
      loaded: (data) => next = success(data),
      error:  (message) => error != null ? next = error! : next = FailedWidget(
        error: message,
        onPressed: onError,
      ),
    );
    return next;
  }
}
