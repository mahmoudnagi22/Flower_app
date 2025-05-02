import 'package:flower_app/features/notifications_list/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});
  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: .44,
        children: [
          SlidableAction(
            onPressed: (context) {
              // deleteTask(task.id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            icon: Icons.delete,
            label: 'delete',
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.notifications_none),
        title: Text(notification.title),
        subtitle: Text(
          notification.body,
          style: TextStyle(overflow: TextOverflow.ellipsis),
          maxLines: 2,
        ),
      ),
    );
  }
}
