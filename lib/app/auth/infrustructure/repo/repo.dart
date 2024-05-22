import 'package:either_dart/src/either.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/constant/keys.dart';
import '../../../../common/network/exception/error_handler.dart';
import '../../../../injection/injection.dart';
import '../../domain/repo/repo.dart';
import '../data_source/remote/remote.dart';
import '../model/auth.dart';

class RepoAuthImpl implements RepoAuth {
  final RemoteAuth _remote;

  RepoAuthImpl({required final RemoteAuth remote}) : _remote = remote;

  @override
  Future<Either<String, User>> login(
      {required String username, required String password}) {
    return throwAppException(() async {
      final result =
          await _remote.login(username: username, password: password);
      await getIt<SharedPreferences>().setString(kToken, result["token"]);
      return User.fromJson(result);
    });
  }
}
