import 'package:flower_app/features/notifications_list/domain/entities/notification_entity.dart';
import 'package:flower_app/features/notifications_list/domain/usecases/add_notification_usecase.dart';
import 'package:flower_app/features/notifications_list/domain/usecases/get_all_notifications_usecase.dart';
import 'package:flower_app/features/notifications_list/domain/usecases/get_notification_usecase.dart';
import 'package:flower_app/features/notifications_list/presentation/view_model/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final GetAllNotificationsUsecase getAllNotificationsUsecase;
  final AddNotificationUsecase addNotificationUsecase;
  final GetNotificationUsecase getNotificationUsecase;
  NotificationCubit(
    this.getAllNotificationsUsecase,
    this.addNotificationUsecase,
    this.getNotificationUsecase,
  ) : super(NotificationInitial());

  void getAllNotifications(String createdAt) async {
    emit(NotificationLoading());
    try {
      final result = await getAllNotificationsUsecase(createdAt);
      emit(NotificationSuccess(result));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> addNotification(NotificationEntity notification) async {
    try {
      await addNotificationUsecase(notification);
      getAllNotifications(notification.createdAt);
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<NotificationEntity?> getNotification(String id) async {
    try {
      return await getNotificationUsecase(id);
    } catch (e) {
      emit(NotificationError(e.toString()));
      return null;
    }
  }
}
