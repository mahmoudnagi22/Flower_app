import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OccasionScreen extends StatelessWidget {
  const OccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.verticalSpace,
            const Text('Occasion'),

            const Text(
              'Bloom with our exquisite best sellers',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
      body: const Column(children: [
        
      ]),
    );
  }
}
