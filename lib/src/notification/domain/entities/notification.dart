import 'package:education/core/enums/notification_enum.dart';
import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.sentAt,
  });

  Notification.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          body: '_empty.body',
          category: NotificationCategory.NONE,
          sentAt: DateTime.now(),
        );

  final String id;
  final String title;
  final String body;
  final NotificationCategory category;
  final DateTime sentAt;

  @override
  List<Object?> get props => [id];
}
