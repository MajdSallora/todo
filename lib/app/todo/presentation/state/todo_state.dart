part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final BlocStatus editStatus;
  final BlocStatus deleteStatus;

  const TodoState(
      {this.editStatus = const BlocStatus.initial(),
      this.deleteStatus = const BlocStatus.initial()});

  TodoState copyWith({BlocStatus? editStatus, BlocStatus? deleteStatus}) {
    return TodoState(
      editStatus: editStatus ?? this.editStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object?> get props => [editStatus, deleteStatus];
}
