import 'package:flutter/material.dart';
import 'package:ayurora/models/plant.dart';
import 'package:ayurora/constants.dart';

class PlantData {
  static List<Plant> getAllPlants() {
    return [
      Plant(
        id: '1',
        name: 'Ashwagandha',
        scientificName: 'Withania somnifera',
        sanskritName: 'अश्वगंधा',
        category: 'Medicinal',
        imageUrl: 'assets/images/image_1.png',
        difficultyLevel: 'Easy',
        growthTime: '6-7 months',
        description: 'Ashwagandha, also known as Indian Ginseng, is one of the most powerful herbs in Ayurvedic healing. It has been used for over 3,000 years to relieve stress, increase energy levels, and improve concentration. This adaptogenic herb helps the body manage stress and promotes overall wellbeing.',
        lightLevel: 'Full Sun',
        waterLevel: 'Low',
        temperature: '20-35°C',
        growthRate: 'Medium',
        price: 440,
        benefits: ['Stress Relief', 'Energy Boost', 'Immunity', 'Brain Health'],
        interestingFacts: [
          'Ashwagandha means "smell of horse" in Sanskrit, referring to its unique smell and ability to increase strength.',
          'It has been used in Ayurvedic medicine for over 3,000 years.',
          'The plant can grow up to 75cm tall and produces small greenish flowers.',
          'Both the roots and berries are used in traditional medicine.',
          'Modern research shows it can reduce cortisol levels by up to 30%.',
        ],
        careInstructions: [
          CareInstruction(
            title: 'Watering',
            description: 'Water sparingly. Allow soil to dry between waterings. Overwatering can cause root rot.',
            icon: Icons.water_drop,
            color: kPrimaryColor,
          ),
          CareInstruction(
            title: 'Light Requirements',
            description: 'Requires full sun exposure for 6-8 hours daily for optimal growth.',
            icon: Icons.wb_sunny,
            color: Colors.orange,
          ),
          CareInstruction(
            title: 'Soil & Drainage',
            description: 'Prefers well-drained sandy or loamy soil with good drainage. Avoid waterlogged conditions.',
            icon: Icons.terrain,
            color: Colors.brown,
          ),
          CareInstruction(
            title: 'Harvesting',
            description: 'Roots can be harvested after 150-180 days. Dry in shade before use.',
            icon: Icons.agriculture,
            color: kPrimaryColor,
          ),
        ],
        backgroundColor: kPrimaryColor,
      ),
      Plant(
        id: '2',
        name: 'Tulsi',
        sanskritName: 'तुलसी',
        scientificName: 'Ocimum sanctum',
        category: 'Medicinal',
        imageUrl: 'assets/images/image_2.png',
        difficultyLevel: 'Easy',
        growthTime: '3-4 months',
        description: 'Tulsi, or Holy Basil, is revered in Ayurveda as the "Queen of Herbs". This sacred plant has powerful healing properties and is known for its ability to purify the air, boost immunity, and promote mental clarity. It is commonly used in teas and traditional remedies.',
        lightLevel: 'Full Sun',
        waterLevel: 'Moderate',
        temperature: '20-30°C',
        growthRate: 'Fast',
        price: 380,
        benefits: ['Immunity Boost', 'Respiratory Health', 'Stress Relief', 'Antioxidant'],
        interestingFacts: [
          'Tulsi is considered sacred in Hindu tradition and is often planted in courtyards.',
          'It can purify the air by absorbing harmful gases and releasing oxygen.',
          'There are three main varieties: Rama, Krishna, and Vana Tulsi.',
          'Tulsi leaves contain essential oils with powerful antimicrobial properties.',
          'Regular consumption can help regulate blood sugar levels.',
        ],
        careInstructions: [
          CareInstruction(
            title: 'Watering',
            description: 'Water regularly to keep soil moist but not waterlogged. Water daily in summer.',
            icon: Icons.water_drop,
            color: kPrimaryColor,
          ),
          CareInstruction(
            title: 'Light Requirements',
            description: 'Needs 6-8 hours of direct sunlight daily. Can tolerate partial shade.',
            icon: Icons.wb_sunny,
            color: Colors.orange,
          ),
          CareInstruction(
            title: 'Pruning',
            description: 'Regular pruning encourages bushy growth. Pinch off flower buds to promote leaf growth.',
            icon: Icons.content_cut,
            color: Colors.purple,
          ),
          CareInstruction(
            title: 'Fertilizing',
            description: 'Apply organic compost monthly. Avoid chemical fertilizers for medicinal use.',
            icon: Icons.eco,
            color: Colors.green,
          ),
        ],
        backgroundColor: Color(0xFF2D9F6D),
      ),
      Plant(
        id: '3',
        name: 'Aloe Vera',
        scientificName: 'Aloe barbadensis',
        sanskritName: 'घृतकुमारी',
        category: 'Medicinal',
        imageUrl: 'assets/images/image_3.png',
        difficultyLevel: 'Very Easy',
        growthTime: '3-4 years',
        description: 'Aloe Vera is a succulent plant species known for its thick, fleshy leaves containing a gel with numerous medicinal properties. Used for centuries in traditional medicine, it is excellent for skin care, digestive health, and wound healing. This hardy plant requires minimal care and thrives in most conditions.',
        lightLevel: 'Bright Indirect',
        waterLevel: 'Low',
        temperature: '18-30°C',
        growthRate: 'Slow',
        price: 320,
        benefits: ['Skin Care', 'Wound Healing', 'Digestive Aid', 'Hair Health'],
        interestingFacts: [
          'Aloe Vera gel is 99% water and contains over 75 active compounds.',
          'The plant has been used medicinally for over 6,000 years.',
          'Ancient Egyptians called it the "plant of immortality".',
          'A single Aloe Vera plant can produce dozens of offsets or "pups".',
          'The gel contains vitamins A, C, E, and B12, along with essential minerals.',
        ],
        careInstructions: [
          CareInstruction(
            title: 'Watering',
            description: 'Water deeply but infrequently. Allow soil to dry completely between waterings (every 2-3 weeks).',
            icon: Icons.water_drop,
            color: kPrimaryColor,
          ),
          CareInstruction(
            title: 'Light Requirements',
            description: 'Prefers bright, indirect light. Can tolerate some direct morning sun.',
            icon: Icons.wb_sunny,
            color: Colors.orange,
          ),
          CareInstruction(
            title: 'Soil & Potting',
            description: 'Use well-draining cactus/succulent soil. Ensure pot has drainage holes.',
            icon: Icons.yard,
            color: Colors.brown,
          ),
          CareInstruction(
            title: 'Harvesting',
            description: 'Cut outer leaves at the base. Use fresh gel immediately or store in refrigerator.',
            icon: Icons.cut,
            color: Colors.teal,
          ),
        ],
        backgroundColor: Color(0xFF0C9869),
      ),
      Plant(
        id: '4',
        name: 'Neem',
        sanskritName: 'निम्ब',
        scientificName: 'Azadirachta indica',
        category: 'Medicinal',
        imageUrl: 'assets/images/image_1.png',
        difficultyLevel: 'Medium',
        growthTime: '3-5 years',
        description: 'Neem is often called the "Village Pharmacy" in India due to its extensive medicinal properties. Every part of the neem tree - leaves, bark, seeds, and oil - has therapeutic uses. It is highly valued for its antibacterial, antiviral, and antifungal properties, making it a cornerstone of Ayurvedic medicine.',
        lightLevel: 'Full Sun',
        waterLevel: 'Low',
        temperature: '20-35°C',
        growthRate: 'Fast',
        price: 520,
        benefits: ['Antibacterial', 'Skin Health', 'Dental Care', 'Pest Control'],
        interestingFacts: [
          'Neem can live for up to 200 years and grow 15-20 meters tall.',
          'Every part of the neem tree has medicinal properties.',
          'Neem leaves purify the air and have been used as natural pesticides.',
          'Traditional Indian toothbrushes are made from neem twigs.',
          'One neem tree can provide oxygen for 10 people.',
        ],
        careInstructions: [
          CareInstruction(
            title: 'Watering',
            description: 'Water regularly during establishment. Mature trees are drought-tolerant.',
            icon: Icons.water_drop,
            color: kPrimaryColor,
          ),
          CareInstruction(
            title: 'Light Requirements',
            description: 'Requires full sun. Needs at least 6 hours of direct sunlight daily.',
            icon: Icons.wb_sunny,
            color: Colors.orange,
          ),
          CareInstruction(
            title: 'Soil Preparation',
            description: 'Grows well in various soils but prefers well-drained sandy loam.',
            icon: Icons.grass,
            color: Colors.green,
          ),
          CareInstruction(
            title: 'Pruning & Care',
            description: 'Prune to maintain shape. Remove dead branches to promote healthy growth.',
            icon: Icons.content_cut,
            color: Colors.purple,
          ),
        ],
        backgroundColor: Color(0xFF1BA65D),
      ),
      Plant(
        id: '5',
        name: 'Brahmi',
        sanskritName: 'ब्राह्मी',
        scientificName: 'Bacopa monnieri',
        category: 'Medicinal',
        imageUrl: 'assets/images/image_2.png',
        difficultyLevel: 'Easy',
        growthTime: '4-5 months',
        description: 'Brahmi is a powerful brain tonic used in Ayurveda to enhance memory, learning, and concentration. This aquatic herb grows in wetlands and is known for its cognitive-enhancing properties. It helps reduce anxiety and stress while improving mental clarity and focus.',
        lightLevel: 'Partial Shade',
        waterLevel: 'High',
        temperature: '20-30°C',
        growthRate: 'Fast',
        price: 420,
        benefits: ['Memory Enhancement', 'Brain Health', 'Stress Relief', 'Learning Aid'],
        interestingFacts: [
          'Brahmi has been used for over 3,000 years to improve cognitive function.',
          'Ancient scholars consumed Brahmi to memorize long sacred texts.',
          'It can grow both in water and moist soil.',
          'The plant contains bacosides, compounds that enhance neural communication.',
          'Regular use may improve information processing speed.',
        ],
        careInstructions: [
          CareInstruction(
            title: 'Watering',
            description: 'Keep constantly moist or grow in shallow water. Never let soil dry out.',
            icon: Icons.water_drop,
            color: kPrimaryColor,
          ),
          CareInstruction(
            title: 'Light Requirements',
            description: 'Prefers partial shade to filtered sunlight. Protect from harsh afternoon sun.',
            icon: Icons.wb_sunny,
            color: Colors.orange,
          ),
          CareInstruction(
            title: 'Growing Medium',
            description: 'Grows well in aquatic conditions or waterlogged soil rich in organic matter.',
            icon: Icons.water,
            color: Colors.blue,
          ),
          CareInstruction(
            title: 'Harvesting',
            description: 'Harvest leaves regularly to encourage new growth. Use fresh or dried.',
            icon: Icons.spa,
            color: Colors.green,
          ),
        ],
        backgroundColor: Color(0xFF0D8A5F),
      ),
    ];
  }

  static List<Plant> searchPlants(String query) {
    if (query.isEmpty) return getAllPlants();
    
    final lowercaseQuery = query.toLowerCase();
    return getAllPlants().where((plant) {
      return plant.name.toLowerCase().contains(lowercaseQuery) ||
             plant.scientificName.toLowerCase().contains(lowercaseQuery) ||
             plant.category.toLowerCase().contains(lowercaseQuery) ||
             plant.benefits.any((benefit) => benefit.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }
}