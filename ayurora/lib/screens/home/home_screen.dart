import 'package:ayurora/constants.dart';
import 'package:ayurora/screens/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: buildAppBar(),
        body: Body(),
      ); // Replace with actual home screen implementation
    
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {},
        ),
      );
  }
}