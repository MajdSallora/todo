import 'dart:io';
import 'package:dio/dio.dart';

import 'exception/app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      if (err.error is SocketException) {
        err = err.copyWith(error: AppException.known("No Internet Connection"));
        handler.next(err);
      }else if (err.response.toString().isNotEmpty && err.response?.data?["message"] != null) {
          err = err.copyWith(error: AppException.known(err.response?.data?["message"]));
          handler.reject(err);

      } else if (err.type == DioErrorType.connectionTimeout ||
          err.type == DioErrorType.sendTimeout ||
          err.type == DioErrorType.receiveTimeout) {
        err = err.copyWith(error: AppException.known('No Internet Connection'));

        handler.reject(err);
      } else if (err.type == DioErrorType.badResponse && err.response?.statusCode == 500) {
        err = err.copyWith(error: AppException.known('Something want wrong try again!'));
        handler.next(err);
      } else if (err.type == DioErrorType.badResponse) {
        var data = err.response?.data;
        err = err.copyWith(error: data is String ? AppException.known(data) : AppException.unknown());
        handler.next(err);
      } else {
        err = err.copyWith(error: AppException.unknown());
        handler.next(err);
      }
    } catch (_) {
      err = err.copyWith(error: AppException.unknown());
      handler.next(err);
    }
  }
}
