import 'package:flutter/material.dart';

class HomeCategory {
  const HomeCategory({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Lightweight card model used in the home feed.
///
/// [id] links to the full [Eatery] domain model via [EateryRepository].
class EateryCardModel {
  const EateryCardModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.rating,
    required this.distance,
    required this.tags,
    this.rank,
    this.redeemedText,
  });

  final String id;
  final String imageUrl;
  final String name;
  final String category;
  final double rating;
  final String distance;
  final List<String> tags;
  final String? rank;
  final String? redeemedText;
}

class EaterySectionModel {
  const EaterySectionModel({required this.title, required this.items});

  final String title;
  final List<EateryCardModel> items;
}
