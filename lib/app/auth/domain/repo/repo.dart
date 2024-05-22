import 'package:either_dart/either.dart';

import '../../infrustructure/model/auth.dart';

abstract class RepoAuth {
  Future<Either<String, User>> login({required String username, required String password});

}
