import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/resources/color_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../cubits/auto_login_cubit/auto_login_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  StreamSubscription? _authSubscription;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkLoginState();
      }
    });
  }

  void _checkLoginState() {
    final cubit = context.read<AutoLoginCubit>();
    cubit.autoLogin();

    _authSubscription = cubit.stream.listen((state) {


      if (state is AutoLoginSuccess) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, Routes.bottomNav);
        }
      } else if (state is AutoLoginFailure) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        }
      }
    });
  }


  @override
  void dispose() {
    _authSubscription?.cancel();
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: const Text(
            'Flowerly',
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: ColorManager.appColor,
               ),
          ),
        ),
      ),
    );
  }
}
