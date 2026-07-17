import 'package:flutter/material.dart';
import 'package:plantcare/core/colors_manager.dart';

class StyleManager {
  static const bool isMobile = false;
  static const bool isTablet = false;

  static final TextStyle white36header = TextStyle(
    fontSize: isMobile ? 28 : (isTablet ? 36 : 42),
    fontWeight: FontWeight.w700,
    color: AppColor.white,
    fontFamily: 'Inter',
  );
  static final TextStyle white14org = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
    fontFamily: 'Inter',
  );
  static final TextStyle black30header = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 30,
    color: AppColor.black,
  );
  static final TextStyle black14org = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
    fontFamily: 'Poppins',
  );
  static final TextStyle labelStyle = TextStyle(
    color: AppColor.labelText,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 13.43,
  );
  static final TextStyle hinitText = TextStyle(
    color: AppColor.hintText,
    fontSize: 19.53,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
  );
  static final TextStyle userText = TextStyle(
    color: AppColor.black,
    fontSize: 19.53,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
  );
  static final TextStyle smallText = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: AppColor.smallText,
  );
  static final TextStyle textButton = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: AppColor.textButton,
  );
  static final TextStyle termsGray = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColor.termsGray,
  );
  static final TextStyle termsGreen = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColor.termsGreen,
  );
}
