import 'package:ayurora/components/my_bottom_navbar.dart';
import 'package:ayurora/constants.dart';
import 'package:ayurora/screens/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ayurora/screens/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/menu.svg",
          width: 24,
          height: 24,
        ),
        onPressed: () {
          // Show menu or drawer
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Menu coming soon!'),
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
      actions: [
        // Profile button
        /*IconButton(
          icon: Icon(Icons.person, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
        ),*/
      ],
    );
  }
}