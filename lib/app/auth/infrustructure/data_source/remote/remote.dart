import 'package:dio/dio.dart';

import '../../../../../common/constant/url.dart';
import '../../../../../common/network/exception/error_handler.dart';
import '../../model/auth.dart';

class RemoteAuth {
  final Dio _dio;

  const RemoteAuth(Dio dio) : _dio = dio;

  Future<dynamic> login({required String username, required String password}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.login,
        data: {
          "username": username,
          "password": password,
          // "expiresInMins" : 30
        },
      );
      return response.data;
    });
  }
}
