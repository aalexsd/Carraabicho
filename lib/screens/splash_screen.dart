import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/auth_check.dart';
import '../widgets/onboarding.dart';
import 'login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTimeUser = false;


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
  void initState() {
    checkFirstTimeUser();
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textsplash = Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/carrabicho.png'),
                radius: 60,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Carrabicho',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Desenvolvido por Alex',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                )
              ],
            ),

          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 50.0),
            child: Text(
              'Versão Beta',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );

    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: Image.asset('assets/images/splashscreen.png',
      fit: BoxFit.cover,),
      splashIconSize: MediaQuery.of(context).size.height,
      nextScreen: isFirstTimeUser ? OnBoardingPage() : const AuthCheck(),
      splashTransition: SplashTransition.sizeTransition,
    );
  }
}