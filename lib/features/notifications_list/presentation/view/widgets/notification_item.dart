import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.notifications_none),
      title: Text('New Message'),
      subtitle: Text('jskchjqscbhaicbujdbcjbc'),
    );
  }
}
