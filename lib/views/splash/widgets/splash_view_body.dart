import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/views/home/views/home_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: Expanded(
        child: Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      ),

    );
  }

  void navigateToHome() {
    Future.delayed ( Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeView.routeName, (route) => false);
    });
  }
}
//