import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../infrustructure/model/todo.dart';
import '../../state/todo_bloc.dart';
import '../widget/todo_card.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TodoBloc>().skipTodos = 0;
        context.read<TodoBloc>().todosController.refresh();
      },
      child: PagedListView(
        pagingController: context.read<TodoBloc>().todosController,
        padding: EdgeInsets.all(12.r),
        builderDelegate: PagedChildBuilderDelegate<TodoInfoModel>(
            itemBuilder: (BuildContext context, todo, int index) {
          return TodoCard(todo: todo,).animate().slideX(duration: const Duration(milliseconds: 180));
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().todosController.addPageRequestListener((pageKey) {
      context.read<TodoBloc>().add(GetTodos());
    });
  }
}
