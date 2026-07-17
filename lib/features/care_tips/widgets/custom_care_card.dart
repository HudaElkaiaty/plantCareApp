import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: TextStyle(fontSize: 22.sp)),
              SizedBox(width: 10.w),
              Text(
                title,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          const Divider(),

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
                          color: Colors.green[600],
                          size: 7.w,
                        ),
                      ),

                      Expanded(
                        child: Text(
                          tip,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF475569),
                            height: 1.3,
                          ),
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
