import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/common/utils/bloc_status.dart';
import 'package:todo/common/utils/custom_loading.dart';
import '../../application/facade_todo.dart';
import '../../infrustructure/model/todo.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final FacadeTodo _facade;
  int skipTodos = 0;

  final PagingController<int, TodoInfoModel> todosController =
      PagingController(firstPageKey: 1);

  TodoBloc({required FacadeTodo facade})
      : _facade = facade,
        super(TodoState()) {
    on<TodoEvent>((event, emit) async {
      if (event is GetTodos) {
        await getTodos(event, emit);
      } else if (event is AddTodo) {
        await addTodos(event, emit);
      } else if (event is EditTodo) {
        await editTodo(event, emit);
      } else if (event is DeleteTodo) {
        await deleteTodo(event, emit);
      }
    });
  }

  Future<void> getTodos(GetTodos event, Emitter emit) async {
    final result = await _facade.getTodos(skipTodos);
    result.fold((left) {
      todosController.error = left;
    }, (right) {
      if (right.total <= skipTodos) {
        todosController.appendLastPage(right.todos);
      } else {
        todosController.appendPage(right.todos, skipTodos);
        skipTodos = todosController.itemList?.length ?? 0;
      }
    });
  }

  Future<void> addTodos(AddTodo event, Emitter emit) async {
    if (formController.valid) {
      CustomLoading.showLoading();
      final todoData = formController.control(todoController).value;

      final result = await _facade.addTodos(todoData);
      result.fold((left) {
        toastification.dismissAll(delayForAnimation: false);
        toastification.show(
          type: ToastificationType.error,
          title: Text(left),
          style: ToastificationStyle.fillColored,
          autoCloseDuration: const Duration(seconds: 5),
        );
      }, (right) {
        todosController.itemList?.insert(
            0,
            TodoInfoModel(
                id: right.id, todo: right.todo, completed: right.completed));
        todosController.notifyListeners();
        toastification.dismissAll(delayForAnimation: false);
        toastification.show(
          type: ToastificationType.success,
          title: const Text("Todo added successfully"),
          style: ToastificationStyle.fillColored,
          autoCloseDuration: const Duration(seconds: 5),
        );
        formController.reset();
      });
      CustomLoading.closeAllLoading();
    } else {
      formController.markAllAsTouched();
    }
  }

  Future<void> editTodo(EditTodo event, Emitter emit) async {
    CustomLoading.showLoading();
    emit(state.copyWith(editStatus: const BlocStatus.loading()));
    final result =
        await _facade.editeTodos(id: event.id, isCompleted: event.isCompleted);
    result.fold((left) {
      toastification.dismissAll(delayForAnimation: false);
      toastification.show(
        type: ToastificationType.error,
        title: Text(left),
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
      emit(state.copyWith(editStatus: BlocStatus.fail(error: left)));
    }, (right) {
      List<TodoInfoModel>? todos = todosController.itemList;
      todos = todos
        ?..firstWhere((element) => element.id == event.id).completed =
            event.isCompleted;

      todosController.itemList = List.from(todos!.toList());
      toastification.dismissAll(delayForAnimation: false);
      toastification.show(
        type: ToastificationType.success,
        title: const Text("Todo updated successfully"),
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
      emit(state.copyWith(editStatus: const BlocStatus.success()));
    });
    CustomLoading.closeAllLoading();
  }

  Future<void> deleteTodo(DeleteTodo event, Emitter emit) async {
    CustomLoading.showLoading();
    emit(state.copyWith(deleteStatus: const BlocStatus.loading()));

    final result = await _facade.deleteTodos(event.id);
    result.fold((left) {
      toastification.dismissAll(delayForAnimation: false);
      toastification.show(
        type: ToastificationType.error,
        title: Text(left),
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
      emit(state.copyWith(deleteStatus: BlocStatus.fail(error: left)));
    }, (right) {
      final todos = todosController.itemList
        ?..removeWhere((element) => element.id == event.id);
      todosController.itemList = List.of(todos!.toList());
      toastification.dismissAll(delayForAnimation: false);
      toastification.show(
        type: ToastificationType.success,
        title: const Text("Todo deleted successfully"),
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
      emit(state.copyWith(deleteStatus: const BlocStatus.success()));
    });
    CustomLoading.closeAllLoading();
  }

  final formController = FormGroup({
    todoController: FormControl<String>(validators: [Validators.required])
  });

  static const String todoController = "todoController";
}
