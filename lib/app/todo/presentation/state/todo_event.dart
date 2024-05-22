part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class GetTodos extends TodoEvent {}

class AddTodo extends TodoEvent {}

class DeleteTodo extends TodoEvent {
  final int id;

  DeleteTodo({required this.id});
}

class EditTodo extends TodoEvent {
  final int id;
  final bool isCompleted;

  EditTodo({required this.id, required this.isCompleted});
}
