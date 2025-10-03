import 'package:ayurora/models/plant.dart';
import 'package:ayurora/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:ayurora/constants.dart';

class AllPlantsScreen extends StatelessWidget {
  final List<Plant> plants;

  const AllPlantsScreen({
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
          'All Plants',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_florist_outlined,
                    size: _getResponsiveIconSize(context, 80),
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No Plants Available',
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(context, 18),
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  padding: EdgeInsets.all(_getResponsivePadding(context)),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context),
                    crossAxisSpacing: _getResponsivePadding(context),
                    mainAxisSpacing: _getResponsivePadding(context),
                    childAspectRatio: _getChildAspectRatio(context),
                  ),
                  itemCount: plants.length,
                  itemBuilder: (context, index) {
                    return PlantGridCard(
                      plant: plants[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(plant: plants[index]),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  // Responsive helper methods
  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 4; // Desktop/Large tablets
    if (width >= 900) return 3; // Tablets landscape
    if (width >= 600) return 3; // Tablets portrait
    if (width >= 400) return 2; // Large phones
    return 2; // Small phones
  }

  double _getChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 0.85; // Tablets
    if (width >= 600) return 0.8; // Medium devices
    return 0.75; // Small phones (slightly more vertical space without price)
  }

  double _getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 20;
    if (width >= 600) return 16;
    return 12;
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.9; // Very small phones
    return baseSize;
  }

  double _getResponsiveIconSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.8;
    return baseSize;
  }
}

class PlantGridCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantGridCard({
    super.key,
    required this.plant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 20,
              color: kPrimaryColor.withOpacity(0.15),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: plant.backgroundColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isSmallScreen ? 12 : 16),
                    topRight: Radius.circular(isSmallScreen ? 12 : 16),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: 'plant_${plant.id}',
                        child: Image.asset(
                          plant.imageUrl,
                          height: _getImageHeight(context),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.local_florist,
                              size: _getImageHeight(context) * 0.6,
                              color: plant.backgroundColor,
                            );
                          },
                        ),
                      ),
                    ),
                    if (plant.isFavorite)
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
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      plant.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 14),
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      plant.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 10),
                        color: plant.backgroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 6 : 8,
                        vertical: isSmallScreen ? 3 : 4,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(isSmallScreen ? 8 : 12),
                      ),
                      child: Text(
                        plant.difficultyLevel,
                        style: TextStyle(
                          fontSize: _getResponsiveFontSize(context, 10),
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getImageHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 120;
    if (width >= 600) return 100;
    if (width < 360) return 80;
    return 100;
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.85; // Small phones
    if (width < 400) return baseSize * 0.9; // Medium-small phones
    return baseSize;
  }
}