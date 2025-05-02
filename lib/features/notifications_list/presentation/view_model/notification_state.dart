// presentation/cubit/notification_state.dart
import '../../domain/entities/notification_entity.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<NotificationEntity> notifications;

  NotificationSuccess(this.notifications);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}
