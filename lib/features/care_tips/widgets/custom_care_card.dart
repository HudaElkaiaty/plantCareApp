import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/core/color_manager.dart'; 
import 'package:plantcare/core/style_manager.dart'; 

class CareTipCard extends StatelessWidget {
  final String title;
  final String icon;
  final List<String> tips;

  const CareTipCard({
    super.key,
    required this.title,
    required this.icon,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor, 
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.borderGray), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                icon, 
                style: TextStyle(fontSize: 22.sp), 
              ),
              SizedBox(width: 10.w),
              Text(
  title,
  style: StyleManager.tipCardTitleStyle, 
),
            ],
          ),
          SizedBox(height: 10.h),
          const Divider(color: ColorManager.dividerColor),

          Column(
            children: [
              for (var tip in tips)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, right: 6.w), 
                        child: Icon(
                          Icons.circle,
                          color: ColorManager.bulletGreen, 
                          size: 7.w,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          tip,
                          style: StyleManager.tipBodyStyle, 
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}