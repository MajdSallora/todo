import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/app/todo/infrustructure/model/todo.dart';
import 'package:todo/app/todo/presentation/state/todo_bloc.dart';
import 'package:todo/common/theme/color.dart';
import 'package:todo/common/utils/extensions/context_extension.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.todo});

  final TodoInfoModel todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.r, horizontal: 5.r),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (ctx) {
                return Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        children: [
                          Text(
                            todo.todo,
                            style: context.textTheme.titleMedium,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: todo.completed,
                              onChanged: (_) {
                                context.read<TodoBloc>().add(EditTodo(
                                    id: todo.id, isCompleted: !todo.completed));
                                Navigator.of(ctx).pop();
                              }),
                          const Text("I have complete this task?")
                        ],
                      ),
                      SizedBox(height: 4.r,),
                      SizedBox(
                        width: double.maxFinite,
                        child: OutlinedButton(
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(DeleteTodo(id: todo.id));
                              Navigator.of(ctx).pop();

                            },
                            style: ElevatedButton.styleFrom(side: const BorderSide(color: AppColors.red)),
                            child: Text("Delete Task!",style: context.textTheme.bodyLarge!.copyWith(color: AppColors.red),)),
                      )
                    ],
                  ),
                );
              });
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(
                      todo.todo,
                      style: context.textTheme.titleMedium,
                    )
                  ],
                ),
                Visibility(
                    visible: todo.completed,
                    replacement: Row(
                      children: [
                        Text(
                          "Status: ",
                          style: context.textTheme.labelSmall,
                        ),
                        Text("not completed",
                            style: context.textTheme.labelSmall!
                                .copyWith(color: AppColors.red))
                      ],
                    ),
                    child: Row(
                      children: [
                        Text("Status: ", style: context.textTheme.labelSmall),
                        Text(
                          "completed",
                          style: context.textTheme.labelSmall!
                              .copyWith(color: AppColors.green),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
