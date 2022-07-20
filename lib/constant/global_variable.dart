import 'package:flutter/material.dart';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );
  static const divider = Divider(
    color: Colors.grey,
    height: 0.5,
    thickness: 0.5,
  );
  // STATIC IMAGES

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color(0xFF074CB2);
  static const unselectedNavBarColor = Colors.white;
  static const mainThemeColor = Color(0xFF074CB2);
  static const textColor = Color(0xFF3377FF);
}
