import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flower App" ,style: TextStyle(fontSize: 34 ,color: Colors.green ),),
      ),
    );
  }
}
