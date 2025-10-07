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
  
  // Ayurvedic properties
  final List<String> usedParts;
  final AyurvedicProperties ayurvedicProperties;
  final List<String> therapeuticUses;
  final List<String> modernTherapeutics;
  final String dose;
  final List<String> importantFormulations;
  final String macroscopicDescription;
  final String microscopicDescription;
  final List<String> constituents;
  final String gunaShloka;

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
    required this.modernTherapeutics,
    required this.dose,
    required this.importantFormulations,
    required this.macroscopicDescription,
    required this.microscopicDescription,
    required this.constituents,
    this.gunaShloka = '',
  });

  // Factory method to create a plant from JSON
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      sinhalaName: json['sinhalaName'] ?? '',
      sanskritName: json['sanskritName'] ?? '',
      scientificName: json['scientificName'] ?? '',
      englishName: json['englishName'] ?? '',
      family: json['family'] ?? '',
      synonyms: List<String>.from(json['synonyms'] ?? []),
      category: json['category'] ?? 'Medicinal',
      imageUrl: json['imageUrl'] ?? '',
      galleryImages: List<String>.from(json['galleryImages'] ?? []),
      difficultyLevel: json['difficultyLevel'] ?? 'Medium',
      growthTime: json['growthTime'] ?? '',
      description: json['description'] ?? '',
      lightLevel: json['lightLevel'] ?? 'Full Sun',
      waterLevel: json['waterLevel'] ?? 'Moderate',
      temperature: json['temperature'] ?? '20-30°C',
      growthRate: json['growthRate'] ?? 'Medium',
      benefits: List<String>.from(json['benefits'] ?? []),
      careInstructions: List<CareInstruction>.from(
        (json['careInstructions'] ?? []).map((x) => CareInstruction.fromJson(x)),
      ),
      interestingFacts: List<String>.from(json['interestingFacts'] ?? []),
      price: json['price'] ?? 0,
      backgroundColor: Color(json['backgroundColor'] ?? kPrimaryColor.value),
      isFavorite: json['isFavorite'] ?? false,
      usedParts: List<String>.from(json['usedParts'] ?? []),
      ayurvedicProperties: AyurvedicProperties.fromJson(json['ayurvedicProperties'] ?? {}),
      therapeuticUses: List<String>.from(json['therapeuticUses'] ?? []),
      modernTherapeutics: List<String>.from(json['modernTherapeutics'] ?? []),
      dose: json['dose'] ?? '',
      importantFormulations: List<String>.from(json['importantFormulations'] ?? []),
      macroscopicDescription: json['macroscopicDescription'] ?? '',
      microscopicDescription: json['microscopicDescription'] ?? '',
      constituents: List<String>.from(json['constituents'] ?? []),
      gunaShloka: json['gunaShloka'] ?? '',
    );
  }

  // Convert plant to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sinhalaName': sinhalaName,
      'sanskritName': sanskritName,
      'scientificName': scientificName,
      'englishName': englishName,
      'family': family,
      'synonyms': synonyms,
      'category': category,
      'imageUrl': imageUrl,
      'galleryImages': galleryImages,
      'difficultyLevel': difficultyLevel,
      'growthTime': growthTime,
      'description': description,
      'lightLevel': lightLevel,
      'waterLevel': waterLevel,
      'temperature': temperature,
      'growthRate': growthRate,
      'benefits': benefits,
      'careInstructions': careInstructions.map((x) => x.toJson()).toList(),
      'interestingFacts': interestingFacts,
      'price': price,
      'backgroundColor': backgroundColor.value,
      'isFavorite': isFavorite,
      'usedParts': usedParts,
      'ayurvedicProperties': ayurvedicProperties.toJson(),
      'therapeuticUses': therapeuticUses,
      'modernTherapeutics': modernTherapeutics,
      'dose': dose,
      'importantFormulations': importantFormulations,
      'macroscopicDescription': macroscopicDescription,
      'microscopicDescription': microscopicDescription,
      'constituents': constituents,
      'gunaShloka': gunaShloka,
    };
  }

  // Copy with method for easy updates
  Plant copyWith({
    String? id,
    String? name,
    String? sinhalaName,
    String? sanskritName,
    String? scientificName,
    String? englishName,
    String? family,
    List<String>? synonyms,
    String? category,
    String? imageUrl,
    List<String>? galleryImages,
    String? difficultyLevel,
    String? growthTime,
    String? description,
    String? lightLevel,
    String? waterLevel,
    String? temperature,
    String? growthRate,
    List<String>? benefits,
    List<CareInstruction>? careInstructions,
    List<String>? interestingFacts,
    int? price,
    Color? backgroundColor,
    bool? isFavorite,
    List<String>? usedParts,
    AyurvedicProperties? ayurvedicProperties,
    List<String>? therapeuticUses,
    List<String>? modernTherapeutics,
    String? dose,
    List<String>? importantFormulations,
    String? macroscopicDescription,
    String? microscopicDescription,
    List<String>? constituents,
    String? gunaShloka,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      sinhalaName: sinhalaName ?? this.sinhalaName,
      sanskritName: sanskritName ?? this.sanskritName,
      scientificName: scientificName ?? this.scientificName,
      englishName: englishName ?? this.englishName,
      family: family ?? this.family,
      synonyms: synonyms ?? this.synonyms,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      galleryImages: galleryImages ?? this.galleryImages,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      growthTime: growthTime ?? this.growthTime,
      description: description ?? this.description,
      lightLevel: lightLevel ?? this.lightLevel,
      waterLevel: waterLevel ?? this.waterLevel,
      temperature: temperature ?? this.temperature,
      growthRate: growthRate ?? this.growthRate,
      benefits: benefits ?? this.benefits,
      careInstructions: careInstructions ?? this.careInstructions,
      interestingFacts: interestingFacts ?? this.interestingFacts,
      price: price ?? this.price,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      isFavorite: isFavorite ?? this.isFavorite,
      usedParts: usedParts ?? this.usedParts,
      ayurvedicProperties: ayurvedicProperties ?? this.ayurvedicProperties,
      therapeuticUses: therapeuticUses ?? this.therapeuticUses,
      modernTherapeutics: modernTherapeutics ?? this.modernTherapeutics,
      dose: dose ?? this.dose,
      importantFormulations: importantFormulations ?? this.importantFormulations,
      macroscopicDescription: macroscopicDescription ?? this.macroscopicDescription,
      microscopicDescription: microscopicDescription ?? this.microscopicDescription,
      constituents: constituents ?? this.constituents,
      gunaShloka: gunaShloka ?? this.gunaShloka,
    );
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Plant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Plant(id: $id, name: $name, scientificName: $scientificName)';
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

  factory CareInstruction.fromJson(Map<String, dynamic> json) {
    return CareInstruction(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: _getIconDataFromString(json['icon'] ?? ''),
      color: Color(json['color'] ?? Colors.green.value),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'icon': _getStringFromIconData(icon),
      'color': color.value,
    };
  }

  static IconData _getIconDataFromString(String iconName) {
    switch (iconName) {
      case 'terrain': return Icons.terrain;
      case 'water_drop': return Icons.water_drop;
      case 'park': return Icons.park;
      case 'agriculture': return Icons.agriculture;
      case 'forest': return Icons.forest;
      case 'emoji_nature': return Icons.emoji_nature;
      case 'grass': return Icons.grass;
      case 'eco': return Icons.eco;
      case 'landscape': return Icons.landscape;
      case 'water': return Icons.water;
      case 'spa': return Icons.spa;
      case 'architecture': return Icons.architecture;
      case 'warning': return Icons.warning;
      case 'sunny': return Icons.wb_sunny;
      case 'thermostat': return Icons.thermostat;
      case 'speed': return Icons.speed;
      default: return Icons.help;
    }
  }

  static String _getStringFromIconData(IconData iconData) {
    if (iconData == Icons.terrain) return 'terrain';
    if (iconData == Icons.water_drop) return 'water_drop';
    if (iconData == Icons.park) return 'park';
    if (iconData == Icons.agriculture) return 'agriculture';
    if (iconData == Icons.forest) return 'forest';
    if (iconData == Icons.emoji_nature) return 'emoji_nature';
    if (iconData == Icons.grass) return 'grass';
    if (iconData == Icons.eco) return 'eco';
    if (iconData == Icons.landscape) return 'landscape';
    if (iconData == Icons.water) return 'water';
    if (iconData == Icons.spa) return 'spa';
    if (iconData == Icons.architecture) return 'architecture';
    if (iconData == Icons.warning) return 'warning';
    if (iconData == Icons.wb_sunny) return 'sunny';
    if (iconData == Icons.thermostat) return 'thermostat';
    if (iconData == Icons.speed) return 'speed';
    return 'help';
  }

  CareInstruction copyWith({
    String? title,
    String? description,
    IconData? icon,
    Color? color,
  }) {
    return CareInstruction(
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
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

  factory AyurvedicProperties.fromJson(Map<String, dynamic> json) {
    return AyurvedicProperties(
      rasa: List<String>.from(json['rasa'] ?? []),
      guna: List<String>.from(json['guna'] ?? []),
      virya: json['virya'] ?? '',
      vipaka: json['vipaka'] ?? '',
      karma: List<String>.from(json['karma'] ?? []),
      effectOnTridosha: json['effectOnTridosha'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rasa': rasa,
      'guna': guna,
      'virya': virya,
      'vipaka': vipaka,
      'karma': karma,
      'effectOnTridosha': effectOnTridosha,
    };
  }

  AyurvedicProperties copyWith({
    List<String>? rasa,
    List<String>? guna,
    String? virya,
    String? vipaka,
    List<String>? karma,
    String? effectOnTridosha,
  }) {
    return AyurvedicProperties(
      rasa: rasa ?? this.rasa,
      guna: guna ?? this.guna,
      virya: virya ?? this.virya,
      vipaka: vipaka ?? this.vipaka,
      karma: karma ?? this.karma,
      effectOnTridosha: effectOnTridosha ?? this.effectOnTridosha,
    );
  }

  @override
  String toString() {
    return 'AyurvedicProperties(rasa: $rasa, guna: $guna, virya: $virya, vipaka: $vipaka, karma: $karma, effectOnTridosha: $effectOnTridosha)';
  }
}

// Extension methods for easy filtering and searching
extension PlantExtensions on List<Plant> {
  List<Plant> searchPlants(String query) {
    if (query.isEmpty) return this;
    
    final lowercaseQuery = query.toLowerCase();
    return where((plant) {
      return plant.name.toLowerCase().contains(lowercaseQuery) ||
             plant.sinhalaName.toLowerCase().contains(lowercaseQuery) ||
             plant.sanskritName.toLowerCase().contains(lowercaseQuery) ||
             plant.scientificName.toLowerCase().contains(lowercaseQuery) ||
             plant.englishName.toLowerCase().contains(lowercaseQuery) ||
             plant.family.toLowerCase().contains(lowercaseQuery) ||
             plant.ayurvedicProperties.rasa.any((rasa) => rasa.toLowerCase().contains(lowercaseQuery)) ||
             plant.ayurvedicProperties.guna.any((guna) => guna.toLowerCase().contains(lowercaseQuery)) ||
             plant.therapeuticUses.any((use) => use.toLowerCase().contains(lowercaseQuery)) ||
             plant.benefits.any((benefit) => benefit.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  List<Plant> filterByDosha(String dosha) {
    return where((plant) {
      final effect = plant.ayurvedicProperties.effectOnTridosha.toLowerCase();
      return effect.contains(dosha.toLowerCase()) || 
             effect.contains('thridosha') ||
             effect.contains('tridosha');
    }).toList();
  }

  List<Plant> filterByRasa(List<String> rasas) {
    return where((plant) {
      return rasas.any((rasa) => 
        plant.ayurvedicProperties.rasa.any((plantRasa) => 
          plantRasa.toLowerCase().contains(rasa.toLowerCase())
        )
      );
    }).toList();
  }

  List<Plant> getFavoritePlants() {
    return where((plant) => plant.isFavorite).toList();
  }

  List<Plant> filterByTherapeuticUse(String use) {
    return where((plant) {
      return plant.therapeuticUses.any((therapeuticUse) => 
        therapeuticUse.toLowerCase().contains(use.toLowerCase())
      );
    }).toList();
  }
}