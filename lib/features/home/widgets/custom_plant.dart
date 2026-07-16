import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/features/detail_screen/details_screen.dart';
import 'package:plantcare/features/home/model/plant_model.dart';

class CustomPlant extends StatelessWidget {
  final PlantModel plants;

  const CustomPlant({super.key, required this.plants});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.all(12.w),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(plant: plants),
                ),
              );
            },
            child: Image.asset(
              plants.image,
              fit: BoxFit.contain,
            ),
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          plants.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}