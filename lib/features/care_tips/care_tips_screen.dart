import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/features/care_tips/widgets/custom_care_card.dart';

class CareTipsScreen extends StatelessWidget {
  const CareTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'Plant Care',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Essential Care Tips',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Master the fundamentals of indoor plant care with these comprehensive tips.',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 20.h),
            CareTipCard(
              title: 'Watering',
              icon: '💧',
              tips: [
                'Check soil moisture before watering - stick finger 1-2 inches deep',
                'Water thoroughly until it drains from bottom, then empty saucer',
                'Most plants prefer to dry out slightly between waterings',
                'Use room temperature water to avoid shocking roots',
              ],
            ),

            CareTipCard(
              title: 'Light',
              icon: '☀️',
              tips: [
                'Bright indirect light means near a window with sheer curtains',
                'Rotate plants weekly for even growth',
                'Watch for signs: pale leaves (too much light), leggy growth (too little)',
              ],
            ),

            CareTipCard(
              title: 'Humidity',
              icon: '💨',
              tips: [
                'Most tropical plants prefer 40-60% humidity',
                'Group plants together to create a humid microclimate',
                'Keep plants away from heating vents and drafts',
              ],
            ),

            CareTipCard(
              title: 'Fertilizing',
              icon: '🌿',
              tips: [
                'Feed during growing season (spring and summer)',
                'Use half-strength fertilizer more often than full strength',
                'Dilute liquid fertilizer to prevent root burn',
                'Slow-release pellets are great for beginners',
                'Flush soil with water monthly to remove salt buildup',
                'Reduce or stop fertilizing in fall and winter',
              ],
            ),

            CareTipCard(
              title: 'Potting & Soil',
              icon: '🪴',
              tips: [
                'Repot when roots circle the bottom or grow through drainage holes',
                'Choose pots only 1-2 inches larger than current pot',
                'All pots must have drainage holes',
                'Use well-draining potting mix, not garden soil',
                'Refresh top 2 inches of soil annually if not repotting',
                'Best time to repot is spring when plants are actively growing',
              ],
            ),

            CareTipCard(
              title: 'Common Problems',
              icon: '🔍',
              tips: [
                'Yellow leaves: usually overwatering or poor drainage',
                'Brown tips: low humidity, fluoride in water, or over-fertilizing',
                'Drooping: needs water or too much direct sun',
                'Leggy growth: insufficient light',
                'White residue on soil: mineral buildup from tap water',
                'Check undersides of leaves regularly for pests',
              ],
            ),
          ],
        ),
      ),
    );
  }
}
