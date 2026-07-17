import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/features/home/widgets/plant_card.dart';
import 'package:plantcare/features/indor_screen/indoor_screen.dart';
import 'package:plantcare/features/outdoor/outdoor_screen.dart';

class PlantList extends StatelessWidget {
  const PlantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlantCard(
          image: 'assets/interior.png',
          text: 'Interior Potted Plant',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const IndoorScreen(),
              ),
            );
          },
        ),

        SizedBox(width: 20.w),

        PlantCard(
          image: 'assets/dried-flowers.png',
          text: 'Balcony Potted Plant',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OutdoorScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}