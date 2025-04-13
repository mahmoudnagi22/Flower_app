import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          'Edit profile',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.sp),
            child: InkWell(
              onTap: () {},
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset('assets/images/notification.png'),
                  const Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(backgroundColor: Colors.red, radius: 6),
                      Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
