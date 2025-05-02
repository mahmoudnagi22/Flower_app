import 'package:flower_app/features/notifications_list/data/data_sources/notification_remote_ds_contract.dart';
import 'package:flower_app/features/notifications_list/data/model/notification_model.dart';
import 'package:flower_app/features/notifications_list/domain/entities/notification_entity.dart';
import 'package:flower_app/features/notifications_list/domain/repositories/notification_repo_contract.dart';

class NotificationRepoImpl extends NotificationRepoContract {
  final NotificationRemoteDsContract notificationRemoteDsContract;
  NotificationRepoImpl(this.notificationRemoteDsContract);

  @override
  Future<void> addNotification(NotificationEntity notification) async {
    final model = NotificationModel(
      id: notification.id,
      title: notification.title,
      body: notification.body,
    );
    await notificationRemoteDsContract.addNotification(model);
  }

  @override
  Future<List<NotificationEntity>> getAllNotifications() async {
    return await notificationRemoteDsContract.getAllNotifications();
  }

  @override
  Future<NotificationEntity> getNotification(String id) async {
    return await notificationRemoteDsContract.getNotification(id);
  }
}
