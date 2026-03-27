import 'package:flutter/material.dart';

class HomeCategory {
  const HomeCategory({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class FoodVenueCardModel {
  const FoodVenueCardModel({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.distance,
    required this.tags,
    this.rank,
    this.redeemedText,
  });

  final String imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final String distance;
  final List<String> tags;
  final String? rank;
  final String? redeemedText;
}

class DealSectionModel {
  const DealSectionModel({required this.title, required this.items});

  final String title;
  final List<FoodVenueCardModel> items;
}
