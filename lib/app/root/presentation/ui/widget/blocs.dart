import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo/app/todo/presentation/state/todo_bloc.dart';

import '../../../../../injection/injection.dart';



class RootBlocs extends StatefulWidget {
  const RootBlocs({super.key, required this.builder});

  final WidgetBuilder builder;

  @override
  State<RootBlocs> createState() => _RootBlocsState();
}

class _RootBlocsState extends State<RootBlocs> {
  late final List<SingleChildWidget> blocs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: blocs, child: Builder(
      builder: (context) => widget.builder(context),
    ));
  }

  @override
  void initState() {
    super.initState();
    blocs = [
      BlocProvider.value(value: getIt<TodoBloc>())
    ];
  }
}
