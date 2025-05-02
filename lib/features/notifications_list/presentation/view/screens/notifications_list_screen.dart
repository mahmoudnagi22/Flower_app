import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/notifications_list/presentation/view/widgets/notification_item.dart';
import 'package:flower_app/features/notifications_list/presentation/view_model/notification_cubit.dart';
import 'package:flower_app/features/notifications_list/presentation/view_model/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsListScreen extends StatelessWidget {
  const NotificationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationCubit>()..getAllNotifications(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notification',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationError) {
              return Center(child: Text(state.message));
            } else if (state is NotificationSuccess) {
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  return NotificationItem(
                    notification: state.notifications[index],
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
