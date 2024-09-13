import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/chat/domain/entities/message.dart';
import 'package:education/src/chat/domain/repos/chat_repo.dart';

class SendMessage extends FutureUsecaseWithParams<void, Message> {
  const SendMessage(this._repo);

  final ChatRepo _repo;

  @override
  ResultFuture<void> call(Message params) async => _repo.sendMessage(params);
}
