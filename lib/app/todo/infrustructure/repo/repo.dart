import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/src/either.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../common/network/exception/error_handler.dart';
import '../../domain/repo/repo.dart';
import '../data_source/local/local.dart';
import '../data_source/remote/remote.dart';
import '../model/todo.dart';

class RepoTodoImpl implements RepoTodo {
  final RemoteTodo _remote;
  final LocalTodo _local;

  RepoTodoImpl({required final RemoteTodo remote, required LocalTodo local})
      : _remote = remote,
        _local = local;

  @override
  Future<Either<String, TodoModel>> getTodos(int skipTodos) {
    return throwAppException(() async {
      if (await hasInternet()) {
        final result = await _remote.getTodos(skipTodos);
        final data = TodoModel.fromJson(result.data);
        await _local.insertTodos(data.todos);
        return data;
      } else {
        final result = await _local.getTodos(skipTodos);
        return result;
      }
    });
  }

  @override
  Future<Either<String, bool>> deleteTodos(int id) {
    return throwAppException(() async {
      if (await hasInternet()) {
        final result = await _remote.deleteTodo(id: id);
        return result;
      } else {
        final result = await _local.deleteTodo(id: id);
        return result;
      }
    });
  }

  @override
  Future<Either<String, bool>> editeTodos(
      {required int id, required bool isCompleted}) {
    return throwAppException(() async {
      if (await hasInternet()) {
        final result = await _remote.editTodo(id: id, isCompleted: isCompleted);
        return result;
      } else {
        final result = await _local.editTodo(id: id, isCompleted: isCompleted);
        return result;
      }
    });
  }

  @override
  Future<Either<String, TodoInfoModel>> addTodos(String todo) {
    return throwAppException(() async {
      if (await hasInternet()) {
        final result = await _remote.addTodo(todo: todo);
        return TodoInfoModel.fromJson(result.data);
      } else {
        final data = TodoInfoModel(id: Random().nextInt(99999), todo: todo, completed: false);
        await _local.insertTodos([data]);
        return data;
      }
    });
  }

  Future<bool> hasInternet() async {
    try{
      final connectivityResult = await Connectivity().checkConnectivity();
      final bool isWifiOrDataOpened =
          connectivityResult.contains(ConnectivityResult.mobile) ||
              connectivityResult.contains(ConnectivityResult.wifi);
      return (isWifiOrDataOpened &&
          await InternetConnectionChecker().hasConnection);
    }catch(_){
      return true;
    }
  }


}
