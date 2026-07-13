import 'package:flutter/material.dart';
import 'package:plantcare/core/color_manager.dart';

class PlantCard extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onPressed;

  const PlantCard({
    super.key,
    required this.image,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              color:ColorManager.greenColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}