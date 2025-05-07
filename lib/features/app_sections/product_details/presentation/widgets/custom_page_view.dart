import 'package:flutter/material.dart';

class CustomPageView extends StatelessWidget{
  const CustomPageView({super.key,required this.pageController,required this.images});
  final List<String>images;
  final PageController ? pageController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PageView(
        controller: pageController,
        children: [
          ...images.map((image)=>Image.network(image,width: double.infinity,fit: BoxFit.cover,)),
        ],
      ),
    );
  }
}