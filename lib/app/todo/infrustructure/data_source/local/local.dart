import 'package:dio/dio.dart';
import 'package:todo/app/todo/infrustructure/model/todo.dart';
import 'package:todo/core/db/Dao/todo/todo_dao.dart';
import 'package:todo/core/db/db.dart';
import '../../../../../common/network/exception/error_handler.dart';
import '../../../../../injection/injection.dart';

class LocalTodo {
  final TodoDao _db = TodoDao(getIt<AppDatabase>());


  Future<TodoModel> getTodos(int skipTodos) {
    return throwDioException(() async {
      final todos = await _db.getAllTodos(skip: skipTodos);
      return todos;
    });
  }

  Future<void> insertTodos(List<TodoInfoModel> todos) {
    return throwDioException(() async {
       await _db.insertTodos(todos);
    });
  }

  Future<bool> editTodo({required int id,required bool isCompleted}) async{
    await _db.updateTodo(id: id, completed: isCompleted);
    return true;
  }

  Future<bool> deleteTodo({required int id}) async{
    await _db.deleteTodo(id: id);
    return true;  }
}
