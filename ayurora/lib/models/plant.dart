import 'package:flutter/material.dart';
import 'package:ayurora/constants.dart';

class Plant {
  final String id;
  final String name;
  final String sinhalaName;
  final String sanskritName;
  final String scientificName;
  final String englishName;
  final String family;
  final List<String> synonyms;
  final String category;
  final String imageUrl;
  final List<String> galleryImages;
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
  
  // New Ayurvedic properties
  final List<String> usedParts;
  final AyurvedicProperties ayurvedicProperties;
  final List<String> therapeuticUses;
  final String dose;
  final List<String> importantFormulations;
  final String macroscopicDescription;
  final String microscopicDescription;
  final List<String> constituents;

  Plant({
    required this.id,
    required this.name,
    required this.sinhalaName,
    required this.sanskritName,
    required this.scientificName,
    required this.englishName,
    required this.family,
    required this.synonyms,
    required this.category,
    required this.imageUrl,
    required this.galleryImages,
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
    required this.usedParts,
    required this.ayurvedicProperties,
    required this.therapeuticUses,
    required this.dose,
    required this.importantFormulations,
    required this.macroscopicDescription,
    required this.microscopicDescription,
    required this.constituents,
  });

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

class AyurvedicProperties {
  final List<String> rasa;
  final List<String> guna;
  final String virya;
  final String vipaka;
  final List<String> karma;
  final String effectOnTridosha;

  AyurvedicProperties({
    required this.rasa,
    required this.guna,
    required this.virya,
    required this.vipaka,
    required this.karma,
    required this.effectOnTridosha,
  });
}