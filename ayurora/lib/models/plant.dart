import 'package:flutter/material.dart';
import 'package:ayurora/constants.dart';

class Plant {
  final String id;
  final String name;
  final String sanskritName;
  final String scientificName;
  final String category;
  final String imageUrl;
  final String difficultyLevel;
  final String growthTime;
  final String description;
  final String lightLevel;
  final String waterLevel;
  final String temperature;
  final String growthRate;
  final List<String> benefits;
  final List<CareInstruction> careInstructions;
  final List<String> interestingFacts;
  final int price;
  final Color backgroundColor;
  bool isFavorite;

  Plant({
    required this.id,
    required this.name,
    required this.sanskritName,
    required this.scientificName,
    required this.category,
    required this.imageUrl,
    required this.difficultyLevel,
    required this.growthTime,
    required this.description,
    required this.lightLevel,
    required this.waterLevel,
    required this.temperature,
    required this.growthRate,
    required this.benefits,
    required this.careInstructions,
    required this.interestingFacts,
    required this.price,
    this.backgroundColor = kPrimaryColor,
    this.isFavorite = false,
  });

  // Method to toggle favorite
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}

class CareInstruction {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  CareInstruction({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}