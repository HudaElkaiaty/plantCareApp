import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantcare/core/color_manager.dart'; 
import 'package:plantcare/core/style_manager.dart'; 
import 'package:plantcare/features/propagation%20guide/models/prop_guide_model.dart';
import 'package:plantcare/features/propagation%20guide/widgets/tech_card.dart';

class PropagationScreen extends StatelessWidget {
  const PropagationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PropagationTechnique> techniques = [
      PropagationTechnique(
        title: 'Water Propagation',
        description:
            'The easiest method for beginners. Simply place cuttings in water and watch roots grow.',
        icon: Icons.water_drop,
        iconColor: ColorManager.waterBlue, 
        steps: [
          'Cut a healthy stem below a node (where leaves attach)',
          'Remove lower leaves that would sit in water',
          'Place cutting in clean water in a bright, indirect light location',
          'Change water every 3-5 days to prevent bacterial growth',
          'Wait 2-6 weeks for roots to develop (1-2 inches long)',
          'Transfer to soil once roots are established',
        ],
        targetCategories: ['Peperomia Plant', 'Red Anthurium', 'Dracaena'],
      ),
      PropagationTechnique(
        title: 'Soil Propagation',
        description:
            'Direct propagation in soil. More natural but requires patience and careful moisture management.',
        icon: Icons.eco,
        iconColor: ColorManager.soilGreen, 
        steps: [
          'Take a 4-6 inch cutting from a healthy stem',
          'Remove lower leaves, keeping 2-3 at the top',
          'Optional: Dip cut end in rooting hormone',
          'Plant cutting in moist, well-draining potting mix',
          'Cover with plastic bag to maintain humidity',
          'Keep soil consistently moist but not waterlogged',
          'Place in bright, indirect light until roots develop (4-8 weeks)',
        ],
        targetCategories: ['Green Potted Plant', 'Eucalyptus', 'Dried Flower Arrangement'],
      ),
      PropagationTechnique(
        title: 'Division',
        description:
            'Perfect for plants that grow in clumps. Divide the root ball into multiple plants.',
        icon: Icons.content_cut,
        iconColor: ColorManager.divisionRed, 
        steps: [
          'Water plant thoroughly 24 hours before dividing',
          'Remove plant from pot and gently shake off excess soil',
          'Identify natural divisions in the root system',
          'Use clean, sharp knife to separate sections',
          'Ensure each division has roots and shoots',
          'Repot divisions in fresh soil immediately',
          'Water well and keep in shade for a few days to recover',
        ],
        targetCategories: ['Peace Lily', 'Licuala grandis', 'Alocasia'],
      ),
      PropagationTechnique(
        title: 'Leaf Propagation',
        description:
            'Grow entire plants from single leaves. Works best with succulents and certain tropicals.',
        icon: Icons.eco_outlined,
        iconColor: ColorManager.leafTeal, 
        steps: [
          'Select a healthy, mature leaf',
          'Gently twist leaf from stem (clean break)',
          'Let the cut end callus over for 1-3 days',
          'Place on top of well-draining soil',
          'Mist lightly every few days',
          'Wait for roots and baby plantlets to emerge',
          'Once established, plant in individual pots',
        ],
        targetCategories: ['Peperomia Plant'],
      ),
    ];

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground, 
      appBar: AppBar(
        title: const Text(
          'Propagation Guide',
          style: TextStyle(fontWeight: FontWeight.bold), 
        ),
        backgroundColor: ColorManager.whiteColor, 
        foregroundColor: ColorManager.textDarkBody, 
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Propagation Techniques',
              style: StyleManager.cardTitleStyle.copyWith(fontSize: 22.sp), 
            ),
            SizedBox(height: 8.h),
            Text(
              'Learn how to multiply your plant collection! Propagation is an affordable and revolutionary way to grow new plants from your existing ones.',
              style: StyleManager.cardDescriptionStyle, 
            ),
            SizedBox(height: 20.h),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: techniques.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final technique = techniques[index];
                return buildTechniqueCard(context, technique);
              },
            ),
          ],
        ),
      ),
    );
  }
}