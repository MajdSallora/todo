import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo/app/todo/presentation/state/todo_bloc.dart';
import 'package:todo/common/widget/custom_reative_failed.dart';
import '../../../../todo/presentation/ui/screen/todo_screen.dart';
import '../widget/blocs.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RootBlocs(
        builder: (context){
          return Scaffold(
            appBar: AppBar(
              title: const Text("Todo Management"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (ctx) {
                      return Padding(
                        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: ReactiveForm(
                          formGroup: context.read<TodoBloc>().formController,
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomReactiveField(
                                    controller: TodoBloc.todoController,
                                  maxLines: 8,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) => context.read<TodoBloc>().add(AddTodo()),
                                  hintText: "Write your own todo",
                                ),
                                SizedBox(
                                  height: 12.r,
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        context.read<TodoBloc>().add(AddTodo());
                                      },
                                      child: const Text("Add note")),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: const Icon(Icons.add),
            ),
            body: Builder(builder: (context) {
              return WillPopScope(
                onWillPop: () {
                  DateTime now = DateTime.now();
                  if (currentBackPressTime == null ||
                      now.difference(currentBackPressTime!) >
                          const Duration(seconds: 2)) {
                    currentBackPressTime = now;
                    BotToast.showText(text: "Press back button again to exit");
                    return Future.value(false);
                  }
                  return Future.value(true);
                },
                child: const TodoScreen(),
              );
            }),
          );
        },
      ),
    );
  }
}
