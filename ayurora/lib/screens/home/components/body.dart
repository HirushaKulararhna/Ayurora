import 'package:ayurora/constants.dart';
import 'package:ayurora/data/plant_data.dart';
import 'package:ayurora/models/plant.dart';
import 'package:ayurora/screens/all_plants_screen.dart';
import 'package:ayurora/screens/favorite_plants_screen.dart';
import 'package:flutter/material.dart';
import 'favorite_plants.dart';
import 'header_with_searchbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_btn.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Plant> allPlants = [];
  List<Plant> searchResults = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    allPlants = PlantData.getAllPlants();
    searchResults = allPlants;
  }

  void _onSearchChanged(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      searchResults = PlantData.searchPlants(query);
    });
  }

  void _refreshUI() {
    setState(() {
      // This will trigger a rebuild to reflect favorite changes
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(
            size: size,
            onSearchChanged: _onSearchChanged,
          ),
          if (isSearching)
            _buildSearchResults()
          else
            _buildHomeContent(),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Container(
        padding: EdgeInsets.all(kDefaultPadding * 2),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 16),
            Text(
              'No plants found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            'Search Results (${searchResults.length})',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
        ),
        SizedBox(height: 16),
        RecomendsPlants(
          plants: searchResults,
          onRefresh: _refreshUI,
        ),
        SizedBox(height: kDefaultPadding),
      ],
    );
  }

  Widget _buildHomeContent() {
    final favoritePlants = allPlants.where((plant) => plant.isFavorite).toList();
    
    return Column(
      children: [
        TitleWithMoreBtn(
          title: "All Plants", 
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllPlantsScreen(plants: allPlants),
              ),
            ).then((_) => _refreshUI());
          }
        ),
        RecomendsPlants(
          plants: allPlants,
          onRefresh: _refreshUI,
        ),
        TitleWithMoreBtn(
          title: "Favorite Plants", 
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritePlantsScreen(plants: favoritePlants),
              ),
            ).then((_) => _refreshUI());
          }
        ),
        FavoritePlants(
          plants: favoritePlants,
          onRefresh: _refreshUI,
        ),
        SizedBox(height: kDefaultPadding),
      ],
    );
  }
}