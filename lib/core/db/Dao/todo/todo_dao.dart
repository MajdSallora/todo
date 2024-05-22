import 'package:drift/drift.dart';
import 'package:todo/core/db/db.dart';
import 'package:todo/core/db/tables/todo/todo_table.dart';

import '../../../../app/todo/infrustructure/model/todo.dart';

part 'todo_dao.g.dart';

@DriftAccessor(tables: [TodoTable])
class TodoDao extends DatabaseAccessor<AppDatabase> with _$TodoDaoMixin {
  TodoDao(super.db);

  Future<TodoModel> getAllTodos({required int skip}) async {
    final query = select(todoTable)..limit(10, offset: skip);
    final queryTotal = await select(todoTable).get();
    final queryResult = await query.get();
    final todos = queryResult
        .map(
            (e) => TodoInfoModel(id: e.id, todo: e.todo, completed: e.complete))
        .toList();
    return TodoModel(limit: 10, todos: todos, total: queryTotal.length);
  }

  Future<void> insertTodos(List<TodoInfoModel> todos) async {
    todos.forEach((e) async {
      await into(todoTable).insert(
        TodoTableCompanion.insert(
            id: Value(e.id), todo: e.todo, complete: e.completed),
        onConflict: DoUpdate((old) => TodoTableCompanion.custom(
            id: old.id, complete: old.complete, todo: old.todo)),
      );
    });
  }

  Future<void> updateTodo({required int id, required bool completed}) async {
    await (update(todoTable)..where((tbl) => tbl.id.equals(id)))
        .write(TodoTableCompanion(complete: Value(completed)));
  }

  Future<void> deleteTodo({required int id}) async {
    await (delete(todoTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
