import 'package:flutter/material.dart';
import 'package:plantcare/core/color_manager.dart';

class StyleManager {
  static const TextStyle titleStyle = TextStyle(
    color:ColorManager.lightGreenColor,
    fontSize: 45,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia Pro',
  );

   static const TextStyle categoryStyle = TextStyle(
    color:ColorManager.greenColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia Pro',
  );
}
