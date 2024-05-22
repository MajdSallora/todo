import 'package:either_dart/either.dart';

import '../../infrustructure/model/todo.dart';

abstract class RepoTodo {

  Future<Either<String,TodoModel>> getTodos(int skipTodos);
  Future<Either<String,bool>> editeTodos({required int id,required bool isCompleted});
  Future<Either<String,bool>> deleteTodos(int id);
  Future<Either<String,TodoInfoModel>> addTodos(String todo);
}
