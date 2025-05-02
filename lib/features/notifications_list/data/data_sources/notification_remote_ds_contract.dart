import 'package:flower_app/features/notifications_list/data/model/notification_model.dart';

abstract class NotificationRemoteDsContract {
  Future<void> addNotification(NotificationModel notification);
  Future<List<NotificationModel>> getAllNotifications(String createdAt);
  Future<NotificationModel> getNotification(String id);
}
