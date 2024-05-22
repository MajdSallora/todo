import 'package:dio/dio.dart';
import '../../../app/auth/presentation/state/auth_bloc.dart';
import '../../app/auth/application/facade_auth.dart';
import '../../app/auth/infrustructure/data_source/remote/remote.dart';
import '../../app/auth/infrustructure/repo/repo.dart';
import '../injection.dart';

Future<void> authInjection() async {
  getIt.registerSingleton<RemoteAuth>(RemoteAuth(getIt<Dio>()));

  getIt.registerSingleton<RepoAuthImpl>(RepoAuthImpl(
    remote: getIt<RemoteAuth>(),
  ));

  getIt.registerSingleton<FacadeAuth>(
    FacadeAuth(
      remote: getIt<RepoAuthImpl>(),
    ),
  );

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      facade: getIt<FacadeAuth>(),
    ),
  );
}
