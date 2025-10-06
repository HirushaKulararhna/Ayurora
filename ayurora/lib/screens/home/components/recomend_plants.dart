import 'package:ayurora/models/plant.dart';
import 'package:ayurora/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class RecomendsPlants extends StatelessWidget {
  const RecomendsPlants({
    super.key,
    required this.plants,
    this.onRefresh,
  });

  final List<Plant> plants;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: plants.map((plant) {
          return RecomendPlantCard(
            plant: plant,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    plant: plant,
                    onFavoriteToggle: onRefresh,
                  ),
                ),
              ).then((_) {
                if (onRefresh != null) {
                  onRefresh!();
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    super.key,
    required this.plant,
    required this.press,
  });

  final Plant plant;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Hero(
                tag: 'plant_${plant.id}',
                child: Image.asset(
                  plant.imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: plant.backgroundColor.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Icon(
                        Icons.local_florist,
                        size: 60,
                        color: plant.backgroundColor,
                      ),
                    );
                  },
                ),
              ),
              if (plant.isFavorite)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.all(6),
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
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${plant.name}\n".toUpperCase(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          TextSpan(
                            text: plant.sanskritName,
                            style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}