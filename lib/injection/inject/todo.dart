import 'package:dio/dio.dart';
import 'package:todo/app/todo/infrustructure/data_source/local/local.dart';
import 'package:todo/app/todo/infrustructure/data_source/remote/remote.dart';
import '../../app/todo/application/facade_todo.dart';
import '../../app/todo/infrustructure/repo/repo.dart';
import '../../app/todo/presentation/state/todo_bloc.dart';
import '../injection.dart';

Future<void> todoInjection() async {

  getIt.registerSingleton<RemoteTodo>(RemoteTodo(getIt<Dio>()));

  getIt.registerSingleton<RepoTodoImpl>(RepoTodoImpl(
    remote: getIt<RemoteTodo>(),
    local: LocalTodo()
  ));

  getIt.registerSingleton<FacadeTodo>(
    FacadeTodo(
      remote: getIt<RepoTodoImpl>(),
    ),
  );

  getIt.registerFactory<TodoBloc>(
        () => TodoBloc(
      facade: getIt<FacadeTodo>(),
    ),
  );
}
