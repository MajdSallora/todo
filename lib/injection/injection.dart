import 'package:get_it/get_it.dart';

import 'inject/auth.dart';
import 'inject/general.dart';
import 'inject/todo.dart';

final getIt = GetIt.instance;

Future<void> initInjection({bool kTestMode = false}) async {
  await generalInjection(kTestMode: kTestMode);
  await authInjection();
  await todoInjection();

}