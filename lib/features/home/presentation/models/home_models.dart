import 'package:flutter/material.dart';

class HomeCategory {
  const HomeCategory({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class RecipeCardModel {
  const RecipeCardModel({
    required this.imageUrl,
    required this.title,
    required this.cuisine,
    required this.duration,
    required this.rating,
  });

  final String imageUrl;
  final String title;
  final String cuisine;
  final String duration;
  final double rating;
}
