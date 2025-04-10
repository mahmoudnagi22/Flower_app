import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/util/ui_dialog.dart';
import 'package:flower_app/features/app_sections/home/screen/cubit/home_cubit.dart';
import 'package:flower_app/features/app_sections/home/screen/cubit/home_states.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/app_bar_search.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/best_seller_item.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/categories_item.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/location.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/occasion_item.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<HomeTabCubit>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabCubit, HomeStates>(
      builder: (context, state) {
        if(state is HomeLoadingStates){
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeSuccessStates) {
          return Padding(
            padding:  REdgeInsets.only(top: 40.0),
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      AppBarSearch(),
                      Location(),
                      TitleOfGroup(nameOfGroup: "Categories" , routesNamed:  Routes.categories,),
                      SizedBox(
                        height: 100.h,
                        child: ListView.builder(itemBuilder: (context, index) {
                          return CategoriesItem(category: state.categories[index],);
                        },itemCount: state.categories.length,scrollDirection: Axis.horizontal,),
                      ),
                      TitleOfGroup(nameOfGroup: "Best seller" , routesNamed: "",),
                      SizedBox(
                        height: 195.h,
                        child: ListView.builder(itemBuilder: (context, index) {
                          return BestSellerItem(bestSeller: state.bestSeller[index],);
                        },itemCount: state.bestSeller.length,scrollDirection: Axis.horizontal,),
                      ),
                      TitleOfGroup(nameOfGroup: "Occasion" , routesNamed: Routes.occasions,),
                      SizedBox(
                        height: 195.h,
                        child: ListView.builder(itemBuilder: (context, index) {
                          return OccasionItem(occasions: state.occasions[index],);
                        },itemCount: state.occasions.length,scrollDirection: Axis.horizontal,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }else {
          return const Center(child: Text("Something went wrong"));
        }
      },
    );

  }
}


//
// BlocProvider(
// create: (context) => HomeTabCubit(),
// child: Padding(
// padding:  REdgeInsets.only(top: 40.0),
// child: Scaffold(
// body: SingleChildScrollView(
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 25.0),
// child: Column(
// children: [
// AppBarSearch(),
// Location(),
// TitleOfGroup(nameOfGroup: "Categories"),
// SizedBox(
// height: 100.h,
// child: ListView.builder(itemBuilder: (context, index) {
// return CategoriesItem();
// //BestSellerItem();
// //CategoriesItem();
// },itemCount: 20,scrollDirection: Axis.horizontal,),
// ),
// TitleOfGroup(nameOfGroup: "Best seller"),
// SizedBox(
// height: 195.h,
// child: ListView.builder(itemBuilder: (context, index) {
// return BestSellerItem();
// },itemCount: 20,scrollDirection: Axis.horizontal,),
// ),
// TitleOfGroup(nameOfGroup: "Occasion"),
// SizedBox(
// height: 195.h,
// child: ListView.builder(itemBuilder: (context, index) {
// return OccasionItem();
// },itemCount: 20,scrollDirection: Axis.horizontal,),
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// );