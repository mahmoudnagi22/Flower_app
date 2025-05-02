import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/features/notifications_list/data/data_sources/notification_remote_ds_contract.dart';
import 'package:flower_app/features/notifications_list/data/model/notification_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRemoteDsContract)
class NotificationRemoteDsImp implements NotificationRemoteDsContract {
  final ApiManager _apiManager;
  NotificationRemoteDsImp(this._apiManager);

  @override
  Future<void> addNotification(NotificationModel notification) async {
    await _apiManager.postRequest(
      AppConstants.notifications,
      notification.toJson(),
    );
  }

  @override
  Future<List<NotificationModel>> getAllNotifications() async {
    final response = await _apiManager.getRequest(
      '${AppConstants.notifications}?sort=-createdAt',
    );
    return (response?.data['notifications'] as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
  }

  @override
  Future<NotificationModel> getNotification(String id) async {
    final response = await _apiManager.getRequest(
      '${AppConstants.notifications}/$id',
    );
    return NotificationModel.fromJson(response?.data['metadata']);
  }
}
