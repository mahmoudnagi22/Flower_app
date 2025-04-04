import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/core/resources/color_manager.dart';

class CustomSliverScreen extends StatefulWidget {
  final bool isSearch;
  final bool multipleChoice;
  final String? appBarTitle;
  final String? appBarSubTitle;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String image;
  final String title;
  final double price;
  final double oldPrice;
  final double discount;
  final int? itemCount;
  final int? categoriesLength;
  final List<String> categories;
  const CustomSliverScreen({
    super.key,
    required this.isSearch,
    required this.multipleChoice,
    this.appBarTitle,
    this.appBarSubTitle,
    this.onChanged,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    this.onTap,
    this.itemCount,
    this.categoriesLength,
    required this.categories,
  });

  @override
  State<CustomSliverScreen> createState() => _CustomSliverScreenState();
}

class _CustomSliverScreenState extends State<CustomSliverScreen> {
  int selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: CustomScrollView(
        slivers: [
          if (widget.isSearch)
            SliverAppBar(
              pinned: true,
              floating: true,
              toolbarHeight: 100,
              backgroundColor: ColorManager.white,
              elevation: 0,
              leading: const SizedBox(),
              leadingWidth: 0,
              title: Row(
                children: [
                  SizedBox(
                    height: 48.h,
                    width: 270.w,
                    child: SearchBar(
                      onChanged: widget.onChanged,
                      leading: SvgPicture.asset(IconsAssets.search),
                      hintText: "Search",
                      hintStyle: WidgetStatePropertyAll(TextStyle(
                          color: ColorManager.textField,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp)),
                      elevation: const WidgetStatePropertyAll(0),
                      backgroundColor: const WidgetStatePropertyAll(ColorManager.white),
                      side: const WidgetStatePropertyAll(BorderSide(color: Color(0xffA6A6A6))),
                      shape: const WidgetStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 48.h,
                    width: 60.w,
                    padding: EdgeInsets.all(13.sp),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffA6A6A6)),
                    ),
                    child: SvgPicture.asset(IconsAssets.filter),
                  ),
                ],
              ),
            )
          else
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: ColorManager.white,
              toolbarHeight: 100,
              elevation: 0,
              leadingWidth: 25.w,
              leading: Padding(
                padding: EdgeInsets.only(left: 18.w),
                child: const Icon(Icons.arrow_back_ios, color: ColorManager.black, size: 20),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(widget.appBarTitle ?? "",
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: ColorManager.black)),
                  SizedBox(height: 5.h),
                  Text(widget.appBarSubTitle ?? "",
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: ColorManager.gray)),
                ],
              ),
            ),

          if (widget.multipleChoice)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.categoriesLength??widget.categories.length,
                  separatorBuilder: (context, index) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedCategoryIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            widget.categories[index],
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: isSelected ? ColorManager.appColor : ColorManager.textField,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: 30.w,
                            height: 2,
                            color: isSelected ? ColorManager.appColor : ColorManager.textField,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Card(
                    color: ColorManager.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: ColorManager.textField.withOpacity(.7)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.asset(widget.image, fit: BoxFit.cover),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(widget.title,
                                  style: TextStyle(
                                      color: ColorManager.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Text("EGP ${widget.price.toInt()}",
                                    style: TextStyle(
                                        color: ColorManager.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(width: 5.w),
                                Text("${widget.oldPrice.toInt()}",
                                    style: TextStyle(
                                        color: ColorManager.gray,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: ColorManager.gray)),
                                SizedBox(width: 5.w),
                                Text("${widget.discount.toInt()}%",
                                    style: TextStyle(
                                        color: ColorManager.green,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Container(
                              width: 147.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: ColorManager.appColor,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(IconsAssets.cart, height: 18, width: 18),
                                  SizedBox(width: 8.w),
                                  Text("Add to cart",
                                      style: TextStyle(
                                          color: ColorManager.white,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: widget.itemCount??10,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
