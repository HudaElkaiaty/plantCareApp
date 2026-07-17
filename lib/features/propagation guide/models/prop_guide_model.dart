import 'package:flutter/material.dart';

class PropagationTechnique {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final List<String> steps;
  final List<String> targetCategories; 

  PropagationTechnique({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.steps,
    required this.targetCategories,
  });
}