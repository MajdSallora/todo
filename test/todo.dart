import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/app/auth/presentation/state/auth_bloc.dart';
import 'package:todo/app/todo/infrustructure/data_source/remote/remote.dart';
import 'package:todo/app/todo/infrustructure/model/todo.dart';
import 'package:todo/app/todo/presentation/state/todo_bloc.dart';
import 'package:todo/common/constant/url.dart';
import 'package:todo/common/utils/bloc_status.dart';
import 'package:todo/core/db/Dao/todo/todo_dao.dart';
import 'package:todo/core/db/db.dart';
import 'package:todo/injection/injection.dart';

void main() {
/*  Note if you get error (Failed to load dynamic library sqlite3.dll)
    you should download sqlite3.dll on your Pc
    and add to your environment variables*/
  late AppDatabase database;
  late TodoDao todoDao;
  late DioAdapter dioAdapter;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    database = AppDatabase.forTesting(NativeDatabase.memory());
    getIt.registerSingleton<AppDatabase>(database);
    await initInjection(kTestMode: true);
    todoDao = TodoDao(database);
    dioAdapter =
        DioAdapter(dio: getIt<Dio>(), matcher: const UrlRequestMatcher());
    dioAdapter.onGet(
        AppUrl.getTodos,
        (server) => server.reply(200, {
              "todos": [
                {
                  "id": 0,
                  "todo": "Do something nice for someone I care about",
                  "completed": true,
                  "userId": 26
                },
                {
                  "id": 1,
                  "todo": "Do something nice for someone I care about",
                  "completed": false,
                  "userId": 26
                }
              ],
              "total": 150,
              "skip": 0,
              "limit": 10
            }));
    dioAdapter.onPost(
        AppUrl.addTodo,
        (server) => server.reply(200, {
              "id": 151,
              "todo": "Hello World",
              "completed": false,
              "userId": 5
            }));
    dioAdapter.onDelete(
        AppUrl.deleteTodos(0),
        (server) => server.reply(200, {
              "id": 151,
              "todo": "Use DummyJSON in the project",
              "completed": false,
              "userId": 5,
              "isDeleted": true,
            }));
    dioAdapter.onPatch(
        AppUrl.editTodos(0),
        (server) => server.reply(200, {
              "id": 151,
              "todo": "Use DummyJSON in the project",
              "completed": false,
              "userId": 5,
            }));
  });
  tearDownAll(() async {
    await database.close();
    await getIt.reset();
    await getIt.unregister<AppDatabase>();
  });

  test('Todo Crud', () async {
    final fakeTodos = [
      TodoInfoModel(id: 0, todo: "Test", completed: true),
      TodoInfoModel(id: 1, todo: "Test 2", completed: false)
    ];
    await todoDao.insertTodos(fakeTodos);
    final todos = await todoDao.getAllTodos(skip: 0);
    identical(todos.todos, fakeTodos);
    await todoDao.updateTodo(
        id: fakeTodos.first.id, completed: !fakeTodos.first.completed);
    final updatedTodos = await todoDao.getAllTodos(skip: 0);

    expect(
        updatedTodos.todos
            .firstWhere((element) => element.id == fakeTodos.first.id)
            .completed,
        !fakeTodos.first.completed);

    await todoDao.deleteTodo(id: fakeTodos.first.id);
    final updatedTodos2 = await todoDao.getAllTodos(skip: 0);
    expect(updatedTodos2.total, fakeTodos.length - 1);
  });

  blocTest(
    'Login with bloc success',
    build: () => getIt<AuthBloc>(),
    wait: const Duration(milliseconds: 50),
    setUp: () {
      dioAdapter.onPost(
          AppUrl.login,
          (server) => server.reply(200, {
                "id": 15,
                "username": "kminchelle",
                "email": "kminchelle@qq.com",
                "firstName": "Jeanne",
                "lastName": "Halvorson",
                "gender": "female",
                "image": "https://robohash.org/Jeanne.png?set=set4",
                "token":
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvSmVhbm5lLnBuZz9zZXQ9c2V0NCIsImlhdCI6MTcxMTIwOTAwMSwiZXhwIjoxNzExMjEyNjAxfQ.F_ZCpi2qdv97grmWiT3h7HcT1prRJasQXjUR4Nk1yo8"
              }));
    },
    act: (bloc) => bloc.add(Login()),
    expect: () => [
      const AuthState(signInState: BlocStatus.loading()),
      const AuthState(signInState: BlocStatus.success())
    ],
  );

  blocTest(
    'Login with bloc failure',
    build: () => getIt<AuthBloc>(),
    wait: const Duration(milliseconds: 50),
    setUp: () {
      dioAdapter.onPost(AppUrl.login,
          (server) => server.reply(404, {"message": "User not found"}));
    },
    act: (bloc) => bloc.add(Login()),
    expect: () => [
      const AuthState(signInState: BlocStatus.loading()),
      const AuthState(signInState: BlocStatus.fail(error: "User not found"))
    ],
  );

  test('Todo Bloc Get Todos', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final todoBloc = getIt<TodoBloc>()..add(GetTodos());
    Future.delayed(const Duration(milliseconds: 50), () {
      expect(todoBloc.todosController.itemList?.isNotEmpty, true);
    });
  });

  test('Todo Api', () async {
    final remote = getIt<RemoteTodo>();
    final resultAllTodos = await remote.getTodos(0);
    final todoDecoded = TodoModel.fromJson(resultAllTodos.data);
    expect(resultAllTodos.statusCode, 200);
    final addTodoResult = await remote.addTodo(todo: "Hello World");
    expect(TodoInfoModel.fromJson(addTodoResult.data).todo, "Hello World");

    final updateTodoResult = await remote.editTodo(
        id: todoDecoded.todos.first.id,
        isCompleted: !todoDecoded.todos.first.completed);
    expect(updateTodoResult, true);
    final deleteTodoResult =
        await remote.deleteTodo(id: todoDecoded.todos.first.id);
    expect(deleteTodoResult, true);
  });
}
