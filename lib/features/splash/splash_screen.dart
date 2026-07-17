// lib/features/splash/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:plant_app/core/styles/colors_manager.dart';
import 'package:plant_app/core/styles/styles_manager.dart';
import 'package:plant_app/features/auth/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/background splash screen.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200),
              Text('Plant Care', style: StyleManager.white36header),
              const SizedBox(height: 10),

              Text('Farm at your fingertips', style: StyleManager.white14org),

              const SizedBox(height: 40),

              const CircularProgressIndicator(color: AppColor.white),
            ],
          ),
        ),
      ),
    );
  }
}
