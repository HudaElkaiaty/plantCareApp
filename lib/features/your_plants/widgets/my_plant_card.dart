import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/core/color_manager.dart'; 
import 'package:plantcare/core/style_manager.dart'; 
import 'package:plantcare/features/home/model/plant_model.dart';

class MyPlantCard extends StatelessWidget {
  final PlantModel plant;
  final int index;

  const MyPlantCard({super.key, required this.plant, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/myPlantDetailsScreen', arguments: index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.whiteColor, 
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadowColor, 
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Image.asset(plant.image, fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
              child: Text(
                plant.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.plantCardTitleStyle, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
