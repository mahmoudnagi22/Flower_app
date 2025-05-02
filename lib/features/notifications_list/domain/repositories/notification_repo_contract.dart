import 'package:flower_app/features/notifications_list/domain/entities/notification_entity.dart';

abstract class NotificationRepoContract {
  Future<void> addNotification(NotificationEntity notification);
  Future<List<NotificationEntity>> getAllNotifications(String createdAt);
  Future<NotificationEntity> getNotification(String id);
}
