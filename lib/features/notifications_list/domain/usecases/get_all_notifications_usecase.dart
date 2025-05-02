import 'package:flower_app/features/notifications_list/domain/entities/notification_entity.dart';
import 'package:flower_app/features/notifications_list/domain/repositories/notification_repo_contract.dart';

class GetAllNotificationsUsecase {
  final NotificationRepoContract notificationRepoContract;
  GetAllNotificationsUsecase(this.notificationRepoContract);

  Future<List<NotificationEntity>> call() {
    return notificationRepoContract.getAllNotifications();
  }
}
