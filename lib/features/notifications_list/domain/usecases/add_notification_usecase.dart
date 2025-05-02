import 'package:flower_app/features/notifications_list/domain/entities/notification_entity.dart';
import 'package:flower_app/features/notifications_list/domain/repositories/notification_repo_contract.dart';

class AddNotificationUsecase {
  final NotificationRepoContract notificationRepoContract;
  AddNotificationUsecase(this.notificationRepoContract);

  Future<void> call(NotificationEntity notification) {
    return notificationRepoContract.addNotification(notification);
  }
}
