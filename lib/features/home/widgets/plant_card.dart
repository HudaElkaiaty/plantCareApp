import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/core/color_manager.dart';

class PlantCard extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onPressed;

  const PlantCard({
    super.key,
    required this.image,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 150.w,
            height: 160.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            text,
            style: TextStyle(
              color: ColorManager.greenColor,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}