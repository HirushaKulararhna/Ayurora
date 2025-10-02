import 'package:ayurora/models/plant.dart';
import 'package:ayurora/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class FavoritePlants extends StatelessWidget {
  const FavoritePlants({
    super.key,
    required this.plants,
  });

  final List<Plant> plants;

  @override
  Widget build(BuildContext context) {
    if (plants.isEmpty) {
      return Container(
        padding: EdgeInsets.all(kDefaultPadding * 2),
        child: Column(
          children: [
            Icon(
              Icons.favorite_border,
              size: 60,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 16),
            Text(
              'No Favorite Plants Yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the heart icon on plants to add them here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: plants.map((plant) {
          return FavoritePlantCard(
            plant: plant,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(plant: plant),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class FavoritePlantCard extends StatelessWidget {
  const FavoritePlantCard({
    super.key,
    required this.plant,
    required this.press,
  });

  final Plant plant;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              plant.backgroundColor,
              plant.backgroundColor.withOpacity(0.7),
            ],
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 30,
              color: plant.backgroundColor.withOpacity(0.4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    plant.scientificName,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Favorite',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: Text(
                plant.category.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.local_florist,
                size: 120,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}