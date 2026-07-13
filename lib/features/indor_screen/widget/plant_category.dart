import 'package:flutter/material.dart';
import 'package:plantcare/features/home/widgets/plant_card.dart';

class PlantCategory extends StatelessWidget {
  const PlantCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
      PlantCard(image: image, text: text, onPressed: onPressed)
  
},
    );
  }
}