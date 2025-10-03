import 'package:ayurora/models/plant.dart';
import 'package:ayurora/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:ayurora/constants.dart';

class FavoritePlantsScreen extends StatelessWidget {
  final List<Plant> plants;

  const FavoritePlantsScreen({
    super.key,
    required this.plants,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Favorite Plants',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: _getResponsiveFontSize(context, 20),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: plants.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _getResponsivePadding(context),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: _getResponsiveIconSize(context, 80),
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No Favorite Plants Yet',
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 18),
                        fontWeight: FontWeight.w600,
                        color: kTextColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: _getResponsivePadding(context) * 2,
                      ),
                      child: Text(
                        'Tap the heart icon on plant details to add them to your favorites',
                        style: TextStyle(
                          fontSize: _getResponsiveFontSize(context, 14),
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(_getResponsivePadding(context)),
              itemCount: plants.length,
              itemBuilder: (context, index) {
                return FavoritePlantListCard(
                  plant: plants[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(plant: plants[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  double _getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 24;
    if (width >= 600) return 20;
    if (width < 360) return 12;
    return 16;
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.9;
    return baseSize;
  }

  double _getResponsiveIconSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.8;
    return baseSize;
  }
}

class FavoritePlantListCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const FavoritePlantListCard({
    super.key,
    required this.plant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final isMediumScreen = screenWidth >= 360 && screenWidth < 600;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: _getResponsiveMargin(context),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            isSmallScreen ? 16 : 20,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 20,
              color: kPrimaryColor.withOpacity(0.15),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: _getImageContainerSize(context),
              height: _getImageContainerSize(context),
              decoration: BoxDecoration(
                color: plant.backgroundColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  isSmallScreen ? 16 : 20,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Hero(
                      tag: 'plant_${plant.id}',
                      child: Image.asset(
                        plant.imageUrl,
                        height: _getImageSize(context),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.local_florist,
                            size: _getImageSize(context) * 0.6,
                            color: plant.backgroundColor,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: isSmallScreen ? 6 : 8,
                    right: isSmallScreen ? 6 : 8,
                    child: Container(
                      padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: isSmallScreen ? 12 : 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(
                  isSmallScreen ? 12 : 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      plant.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 16),
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      plant.scientificName,
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 12),
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 6 : 8,
                            vertical: isSmallScreen ? 3 : 4,
                          ),
                          decoration: BoxDecoration(
                            color: plant.backgroundColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                              isSmallScreen ? 8 : 12,
                            ),
                          ),
                          child: Text(
                            plant.category,
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 10),
                              color: plant.backgroundColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: isSmallScreen ? 12 : 14,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 4),
                            Text(
                              plant.difficultyLevel,
                              style: TextStyle(
                                fontSize: _getResponsiveFontSize(context, 12),
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: isSmallScreen ? 12 : 16,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: isSmallScreen ? 16 : 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getImageContainerSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 140;
    if (width >= 600) return 130;
    if (width < 360) return 100;
    return 120;
  }

  double _getImageSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 100;
    if (width >= 600) return 90;
    if (width < 360) return 70;
    return 80;
  }

  double _getResponsiveMargin(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 20;
    if (width >= 600) return 16;
    if (width < 360) return 12;
    return 16;
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.85;
    if (width < 400) return baseSize * 0.9;
    return baseSize;
  }
}