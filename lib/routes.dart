import 'package:Carrrabicho/commmon/widgets/bottom_nav_screen.dart';
import 'package:Carrrabicho/features/auth/screens/signup_page.dart';
import 'package:Carrrabicho/features/auth/screens/signup_page2.dart';
import 'package:flutter/material.dart';

import 'features/auth/screens/login_page.dart';
import 'features/auth/screens/signup_page3.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginPage.routeName:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case BottomNavScreen.routeName:
      return MaterialPageRoute(builder: (context) => BottomNavScreen());
    case SignUpPage.routeName:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case SignUpPage2.routeName:
      return MaterialPageRoute(builder: (context) => SignUpPage2());
    case SignUpPage3.routeName:
      return MaterialPageRoute(builder: (context) => SignUpPage3());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Page não encontrada.'),
          ),
        ),
      );
  }
}
