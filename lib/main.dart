import 'package:flutter/material.dart';

void main() {

  runApp(const FlowerApp());
}
class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Text("welcome to master branch"),
          )
        ],
      ),
    );
  }
}
//flutter packages pub run build_runner watch
//flutter packages pub run build_runner build