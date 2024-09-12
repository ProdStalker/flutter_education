import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/notifications/domain/entities/notification.dart';
import 'package:education/src/notifications/domain/repos/notification_repo.dart';

class GetNotifications extends StreamUsecaseWithoutParams<List<Notification>> {
  const GetNotifications(this._repo);

  final NotificationRepo _repo;

  @override
  ResultStream<List<Notification>> call() => _repo.getNotifications();
}
