// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $TodoTableTable extends TodoTable
    with TableInfo<$TodoTableTable, TodoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _todoMeta = const VerificationMeta('todo');
  @override
  late final GeneratedColumn<String> todo = GeneratedColumn<String>(
      'todo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, todo, complete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_table';
  @override
  VerificationContext validateIntegrity(Insertable<TodoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('todo')) {
      context.handle(
          _todoMeta, todo.isAcceptableOrUnknown(data['todo']!, _todoMeta));
    } else if (isInserting) {
      context.missing(_todoMeta);
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    } else if (isInserting) {
      context.missing(_completeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      todo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}todo'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $TodoTableTable createAlias(String alias) {
    return $TodoTableTable(attachedDatabase, alias);
  }
}

class TodoTableData extends DataClass implements Insertable<TodoTableData> {
  final int id;
  final String todo;
  final bool complete;
  const TodoTableData(
      {required this.id, required this.todo, required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['todo'] = Variable<String>(todo);
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  TodoTableCompanion toCompanion(bool nullToAbsent) {
    return TodoTableCompanion(
      id: Value(id),
      todo: Value(todo),
      complete: Value(complete),
    );
  }

  factory TodoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoTableData(
      id: serializer.fromJson<int>(json['id']),
      todo: serializer.fromJson<String>(json['todo']),
      complete: serializer.fromJson<bool>(json['complete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'todo': serializer.toJson<String>(todo),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  TodoTableData copyWith({int? id, String? todo, bool? complete}) =>
      TodoTableData(
        id: id ?? this.id,
        todo: todo ?? this.todo,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('TodoTableData(')
          ..write('id: $id, ')
          ..write('todo: $todo, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, todo, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoTableData &&
          other.id == this.id &&
          other.todo == this.todo &&
          other.complete == this.complete);
}

class TodoTableCompanion extends UpdateCompanion<TodoTableData> {
  final Value<int> id;
  final Value<String> todo;
  final Value<bool> complete;
  const TodoTableCompanion({
    this.id = const Value.absent(),
    this.todo = const Value.absent(),
    this.complete = const Value.absent(),
  });
  TodoTableCompanion.insert({
    this.id = const Value.absent(),
    required String todo,
    required bool complete,
  })  : todo = Value(todo),
        complete = Value(complete);
  static Insertable<TodoTableData> custom({
    Expression<int>? id,
    Expression<String>? todo,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (todo != null) 'todo': todo,
      if (complete != null) 'complete': complete,
    });
  }

  TodoTableCompanion copyWith(
      {Value<int>? id, Value<String>? todo, Value<bool>? complete}) {
    return TodoTableCompanion(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      complete: complete ?? this.complete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (todo.present) {
      map['todo'] = Variable<String>(todo.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoTableCompanion(')
          ..write('id: $id, ')
          ..write('todo: $todo, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $TodoTableTable todoTable = $TodoTableTable(this);
  late final TodoDao todoDao = TodoDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoTable];
}

typedef $$TodoTableTableInsertCompanionBuilder = TodoTableCompanion Function({
  Value<int> id,
  required String todo,
  required bool complete,
});
typedef $$TodoTableTableUpdateCompanionBuilder = TodoTableCompanion Function({
  Value<int> id,
  Value<String> todo,
  Value<bool> complete,
});

class $$TodoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TodoTableTable,
    TodoTableData,
    $$TodoTableTableFilterComposer,
    $$TodoTableTableOrderingComposer,
    $$TodoTableTableProcessedTableManager,
    $$TodoTableTableInsertCompanionBuilder,
    $$TodoTableTableUpdateCompanionBuilder> {
  $$TodoTableTableTableManager(_$AppDatabase db, $TodoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TodoTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TodoTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TodoTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> todo = const Value.absent(),
            Value<bool> complete = const Value.absent(),
          }) =>
              TodoTableCompanion(
            id: id,
            todo: todo,
            complete: complete,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String todo,
            required bool complete,
          }) =>
              TodoTableCompanion.insert(
            id: id,
            todo: todo,
            complete: complete,
          ),
        ));
}

class $$TodoTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $TodoTableTable,
    TodoTableData,
    $$TodoTableTableFilterComposer,
    $$TodoTableTableOrderingComposer,
    $$TodoTableTableProcessedTableManager,
    $$TodoTableTableInsertCompanionBuilder,
    $$TodoTableTableUpdateCompanionBuilder> {
  $$TodoTableTableProcessedTableManager(super.$state);
}

class $$TodoTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TodoTableTable> {
  $$TodoTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get todo => $state.composableBuilder(
      column: $state.table.todo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get complete => $state.composableBuilder(
      column: $state.table.complete,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TodoTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TodoTableTable> {
  $$TodoTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get todo => $state.composableBuilder(
      column: $state.table.todo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get complete => $state.composableBuilder(
      column: $state.table.complete,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$TodoTableTableTableManager get todoTable =>
      $$TodoTableTableTableManager(_db, _db.todoTable);
}
