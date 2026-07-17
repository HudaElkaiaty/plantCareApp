import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/core/color_manager.dart'; 
import 'package:plantcare/core/style_manager.dart'; 
import 'package:plantcare/features/propagation%20guide/models/prop_guide_model.dart';

Widget buildTechniqueCard(BuildContext context, PropagationTechnique technique) {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: ColorManager.whiteColor, 
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: ColorManager.shadowColor, 
          blurRadius: 10,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: technique.iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(technique.icon, color: technique.iconColor, size: 28.r),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    technique.title,
                    style: StyleManager.cardTitleStyle, 
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    technique.description,
                    style: StyleManager.cardDescriptionStyle, 
                  ),
                ],
              ),
            ),
          ],
        ),
        
        SizedBox(height: 16.h),
        Text(
          'Step-by-Step Guide:', 
          style: StyleManager.sectionTitleStyle, 
        ),
        SizedBox(height: 10.h),

        ...technique.steps.asMap().entries.map((entry) {
          int stepNum = entry.key + 1;
          String stepText = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.chipBackground, 
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$stepNum',
                    style: StyleManager.stepNumberStyle, 
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    stepText,
                    style: StyleManager.stepBodyStyle, 
                  ),
                ),
              ],
            ),
          );
        }),

        const Divider(height: 24),
        
        Text(
          'Best for:', 
          style: StyleManager.sectionTitleStyle, 
        ),
        SizedBox(height: 8.h),

        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: technique.targetCategories.map((plantName) {
            return Chip(
              label: Text(
                plantName,
                style: StyleManager.chipTextStyle, 
              ),
              backgroundColor: ColorManager.chipBackground, 
              side: BorderSide(
                color: ColorManager.chipBorder, 
                width: 0.8,
              ),
            );
          }).toList(),
        )
      ],
    ),
  );
}