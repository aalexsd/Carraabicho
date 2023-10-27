import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/auth_services.dart';
import '../screens/home_screen.dart';
import '../screens/login_page.dart';
import 'onboarding.dart'; // Importe sua página de OnBoardingPage ou AuthCheck

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool isFirstTimeUser = false;

  @override
  void initState() {
    super.initState();
    checkFirstTimeUser();
  }

  void checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTimeUser = prefs.getBool('isFirstTimeUser') ?? true;

    if (isFirstTimeUser) {
      // É a primeira vez do usuário, direcione-o para a página OnBoardingPage
      prefs.setBool('isFirstTimeUser', false); // Marque que o usuário já não é mais de primeira vez
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnBoardingPage()), // Substitua 'OnBoardingPage' pela sua página real
      );
    } else {
      // O usuário já acessou o aplicativo antes, então direcione-o para a tela de login.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()), // Substitua 'LoginPage' pela sua página real
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const LoginPage();
    } else {
      return HomePage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
