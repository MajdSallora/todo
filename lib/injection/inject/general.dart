import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/constant/url.dart';
import '../../common/network/dio_client.dart';
import '../../core/db/db.dart';
import '../injection.dart';

Future<void> generalInjection({bool kTestMode = false}) async {
  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  getIt.registerSingleton<Dio>(DioClient(AppUrl.baseUrl));
  if(!kTestMode){
    getIt.registerSingleton<AppDatabase>(AppDatabase());
  }
}
