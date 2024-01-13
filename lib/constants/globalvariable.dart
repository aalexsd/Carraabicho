import 'package:flutter/material.dart';

var uri = "http://localhost:8081";
class GlobalVariables {
  // COLORS
  static var appBarGradient = LinearGradient(
    colors: [
      Colors.indigo[300]!,
      Colors.indigo[500]!,
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(91, 140, 238, 0.31);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}
