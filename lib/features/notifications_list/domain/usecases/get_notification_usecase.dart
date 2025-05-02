import 'package:flower_app/features/notifications_list/domain/entities/notification_entity.dart';
import 'package:flower_app/features/notifications_list/domain/repositories/notification_repo_contract.dart';

class GetNotificationUsecase {
  final NotificationRepoContract notificationRepoContract;
  GetNotificationUsecase(this.notificationRepoContract);

  Future<NotificationEntity> call(String id) {
    return notificationRepoContract.getNotification(id);
  }
}
