import 'package:either_dart/either.dart';
import '../infrustructure/model/auth.dart';
import '../infrustructure/repo/repo.dart';

class FacadeAuth {
  final RepoAuthImpl _remote;

  FacadeAuth({
    required RepoAuthImpl remote,
  }) : _remote = remote;

  Future<Either<String, User>> login({required String username, required String password}) =>
      _remote.login(username: username, password: password);

}
