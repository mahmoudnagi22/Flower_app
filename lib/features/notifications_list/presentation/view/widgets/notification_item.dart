import 'package:flower_app/features/notifications_list/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});
  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.notifications_none),
      title: Text(notification.title),
      subtitle: Text(
        notification.body,
        style: TextStyle(overflow: TextOverflow.ellipsis),
        maxLines: 2,
      ),
    );
  }
}
