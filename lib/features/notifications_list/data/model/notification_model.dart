import 'package:flower_app/features/notifications_list/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      title: json['title'],
      body: json['body'],
      createdAt: json['-createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'body': body};
}
