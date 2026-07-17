import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/core/color_manager.dart';

class StyleManager {
  // 1. عنوان الكرت الرئيسي
  static TextStyle cardTitleStyle = TextStyle(
    color: ColorManager.textDarkBody, 
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia Pro',
  );

  // 2. وصف الطريقة الرمادي
  static TextStyle cardDescriptionStyle = TextStyle(
    color: ColorManager.textMuted, 
    fontSize: 12.sp,
    height: 1.3,
    fontFamily: 'Sofia Pro',
  );

  // 3. العناوين الجانبية
  static TextStyle sectionTitleStyle = TextStyle(
    color: ColorManager.textDarkBody, 
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia Pro',
  );

  // 4. رقم الخطوة
  static TextStyle stepNumberStyle = TextStyle(
    color: ColorManager.stepNumberText,
    fontSize: 11.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia Pro',
  );

  // 5. نص الخطوة نفسه
  static TextStyle stepBodyStyle = TextStyle(
    color: ColorManager.textStepBody, 
    fontSize: 12.sp,
    height: 1.3,
    fontFamily: 'Sofia Pro',
  );

  // 6. نص الـ Chip
  static TextStyle chipTextStyle = TextStyle(
    color: ColorManager.chipText, 
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Sofia Pro',
  );

  static TextStyle tipCardTitleStyle = TextStyle(
  color: ColorManager.textDarkBody, 
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sofia Pro',
);

static TextStyle tipBodyStyle = TextStyle(
  color: ColorManager.textLightSlate, 
  fontSize: 14.sp,
  height: 1.3,
  fontFamily: 'Sofia Pro',
);

//drawer
static TextStyle drawerHeaderNameStyle = const TextStyle(
    color: ColorManager.whiteColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia Pro',
  );

  static TextStyle drawerHeaderEmailStyle = const TextStyle(
    color: ColorManager.whiteColor,
    fontSize: 14, 
    fontFamily: 'Sofia Pro',
  );

  static TextStyle drawerItemTitleStyle = const TextStyle(
    color: ColorManager.textDarkBody,
    fontSize: 15, 
    fontWeight: FontWeight.w500,
    fontFamily: 'Sofia Pro',
  );

  static TextStyle drawerLogoutTitleStyle = const TextStyle(
    color: ColorManager.errorRed,
    fontSize: 15, 
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia Pro',
  );

static TextStyle plantCardTitleStyle = TextStyle(
  color: ColorManager.textCharcoal, 
  fontSize: 14.sp,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sofia Pro',
);

static TextStyle emptyStateTextStyle = TextStyle(
  color: ColorManager.textMuted,
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sofia Pro',
);

// (My Plant Details)
  static TextStyle reminderTitleStyle = TextStyle(
    color: ColorManager.textDarkBody,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia Pro',
  );

  static TextStyle reminderValueStyle = TextStyle(
    color: ColorManager.textDarkBody,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Sofia Pro',
  );

  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia Pro',
  );
}
