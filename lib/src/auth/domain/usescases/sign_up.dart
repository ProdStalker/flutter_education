import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignUp extends FutureUsecaseWithParams<void, SignUpParams> {
  const SignUp(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SignUpParams params) {
    return _repo.signUp(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
    );
  }
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParams.empty()
      : email = '',
        password = '',
        fullName = '';

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object?> get props => [
        email,
        password,
        fullName,
      ];
}
