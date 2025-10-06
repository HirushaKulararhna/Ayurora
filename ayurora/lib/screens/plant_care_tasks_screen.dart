// Create: lib/screens/plant_care_tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:ayurora/constants.dart';
import 'package:ayurora/models/plant.dart';
import 'package:ayurora/data/plant_data.dart';

class PlantCareTasksScreen extends StatefulWidget {
  const PlantCareTasksScreen({super.key});

  @override
  State<PlantCareTasksScreen> createState() => _PlantCareTasksScreenState();
}

class _PlantCareTasksScreenState extends State<PlantCareTasksScreen> {
  List<Plant> favoritePlants = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      favoritePlants = PlantData.getAllPlants()
          .where((plant) => plant.isFavorite)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          'My Plant Care',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: favoritePlants.isEmpty
          ? _buildEmptyState()
          : _buildCareList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.eco_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 16),
            Text(
              'No Plants to Care For',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add plants to favorites to track their care',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareList() {
    return ListView(
      padding: EdgeInsets.all(kDefaultPadding),
      children: [
        _buildTodaySection(),
        SizedBox(height: kDefaultPadding * 2),
        _buildUpcomingSection(),
      ],
    );
  }

  Widget _buildTodaySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Tasks',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: kDefaultPadding),
        ...favoritePlants.take(2).map((plant) => _buildCareCard(
              plant: plant,
              task: 'Water',
              icon: Icons.water_drop,
              color: Colors.blue,
              isToday: true,
            )),
      ],
    );
  }

  Widget _buildUpcomingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Care',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: kDefaultPadding),
        ...favoritePlants.skip(2).map((plant) => _buildCareCard(
              plant: plant,
              task: 'Fertilize',
              icon: Icons.science,
              color: Colors.orange,
              daysUntil: 3,
            )),
      ],
    );
  }

  Widget _buildCareCard({
    required Plant plant,
    required String task,
    required IconData icon,
    required Color color,
    bool isToday = false,
    int? daysUntil,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: plant.backgroundColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  plant.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.local_florist,
                      color: plant.backgroundColor,
                      size: 30,
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(icon, size: 16, color: color),
                      SizedBox(width: 4),
                      Text(
                        task,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      if (!isToday && daysUntil != null) ...[
                        SizedBox(width: 8),
                        Text(
                          'in $daysUntil days',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (isToday)
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              )
            else
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
          ],
        ),
      ),
    );
  }
}