import 'package:dio/dio.dart';
import 'package:todo/app/auth/infrustructure/model/auth.dart';
import '../../../../../common/constant/url.dart';
import '../../../../../common/network/exception/error_handler.dart';

class RemoteTodo {
  final Dio _dio;

  const RemoteTodo(Dio dio) : _dio = dio;

  Future<Response> getTodos(int skipTodos) {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getTodos, queryParameters: {
        "skip": skipTodos,
        "limit": 10,
      });
      return response;
    });
  }

  Future<Response> addTodo({required String todo}) {
    return throwDioException(() async {
      final response = await _dio.post(AppUrl.addTodo, data: {
        "todo": todo,
        "completed": false,
        "userId": User.get()?.id,
      });
      return response;
    });
  }

  Future<bool> editTodo({required int id, required bool isCompleted}) {
    return throwDioException(() async {
      final response = await _dio.patch(AppUrl.editTodos(id), data: {
        "completed": isCompleted,
      });
      return response.statusCode == 200;
    });
  }

  Future<bool> deleteTodo({required int id}) {
    return throwDioException(() async {
      final response = await _dio.delete(
        AppUrl.deleteTodos(id),
      );
      return response.statusCode == 200;
    });
  }
}
