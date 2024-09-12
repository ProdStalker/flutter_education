import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/notifications/domain/entities/notification.dart';
import 'package:education/src/notifications/domain/repos/notification_repo.dart';

class SendNotification extends FutureUsecaseWithParams<void, Notification> {
  const SendNotification(this._repo);

  final NotificationRepo _repo;

  @override
  ResultFuture<void> call(Notification params) =>
      _repo.sendNotification(params);
}
