import 'package:flutter/material.dart';
import 'package:ayurora/constants.dart';
import 'package:ayurora/screens/profile/profile_screen.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.local_florist, color: kPrimaryColor, size: 28),
            onPressed: () {
              // Already on home screen
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: kTextColor, size: 28),
            onPressed: () {
              // Navigate to favorites
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Favorites coming soon!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: kTextColor, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}