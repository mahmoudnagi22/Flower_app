import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/occasion_cubit.dart';

class OccasionItem extends StatefulWidget {
  const OccasionItem({super.key, required this.state});

  final OccasionState state;

  @override
  _OccasionItemState createState() => _OccasionItemState();
}

class _OccasionItemState extends State<OccasionItem> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.state.occasionList?.length ?? 0,
      child: Column(
        children: [
          TabBar(

            isScrollable: true,
            indicatorColor: ColorManager.appColor,
            labelColor: ColorManager.appColor,
            unselectedLabelColor: ColorManager.gray,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.center,
            onTap: (value) {
            },
            tabs:
                widget.state.occasionList?.map((occasion) {
                  return Tab(height: 23.h, text: occasion.name ?? '');
                }).toList() ??
                [],
          ),
        ],
      ),
    );
  }
}
