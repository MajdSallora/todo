import 'package:either_dart/either.dart';
import '../infrustructure/model/todo.dart';
import '../infrustructure/repo/repo.dart';

class FacadeTodo {
  final RepoTodoImpl _remote;

  FacadeTodo({
    required RepoTodoImpl remote,
  }) : _remote = remote;

  Future<Either<String,TodoModel>> getTodos(int skipTodos) => _remote.getTodos(skipTodos);
  Future<Either<String,TodoInfoModel>> addTodos(String todo) => _remote.addTodos(todo);
  Future<Either<String,bool>> deleteTodos(int id) => _remote.deleteTodos(id);
  Future<Either<String,bool>> editeTodos({required int id,required bool isCompleted}) => _remote.editeTodos(id: id,isCompleted: isCompleted);
}
