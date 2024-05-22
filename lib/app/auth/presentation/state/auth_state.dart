part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable{
  final BlocStatus signInState;

  const AuthState({
    this.signInState = const BlocStatus.initial(),
  });

  AuthState copyWith({BlocStatus? signInState}) {
    return AuthState(
      signInState: signInState ?? this.signInState,
    );
  }

  @override
  String toString() {
    return signInState.status.name.toString();
  }

  @override
  List<Object?> get props => [signInState];
}
