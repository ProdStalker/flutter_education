import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/notification/domain/repos/notification_repo.dart';

class MarkAsRead extends UsecaseWithParams<void, String> {
  const MarkAsRead(this._repo);

  final NotificationRepo _repo;

  @override
  ResultFuture<void> call(String params) {
    return _repo.markAsRead(params);
  }
}
