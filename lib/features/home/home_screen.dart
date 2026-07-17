import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/features/home/widgets/custom_drawer.dart';
import 'package:plantcare/features/home/widgets/plant_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Care'),
      ),
      drawer: ProfileDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50.h),

              Center(
                child: Image.asset("assets/welcome.png"),
              ),

              SizedBox(height: 60.h),

              const PlantList(),

              Image.asset(
                "assets/nature.png",
                height: 436.h,
                width: 426.w,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}