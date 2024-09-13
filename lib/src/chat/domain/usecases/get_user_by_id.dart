import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/auth/domain/entities/user.dart';
import 'package:education/src/chat/domain/repos/chat_repo.dart';

class GetUserById extends FutureUsecaseWithParams<LocalUser, String> {
  const GetUserById(this._repo);

  final ChatRepo _repo;

  @override
  ResultFuture<LocalUser> call(String params) => _repo.getUserById(params);
}
