import 'package:Carrrabicho/screens/bottom_nav_screen.dart';
import 'package:Carrrabicho/screens/signup.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:Carrrabicho/screens/forgot_password_page.dart';
import 'package:Carrrabicho/screens/home_screen.dart';
import 'package:Carrrabicho/screens/login_page.dart';
import 'package:Carrrabicho/screens/signup_page2.dart';
import 'package:Carrrabicho/screens/signup_page3.dart';
import 'package:Carrrabicho/screens/splash_screen.dart';
import 'package:Carrrabicho/widgets/auth_check.dart';
import 'package:Carrrabicho/widgets/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeuAplicativo extends StatefulWidget {
  MeuAplicativo({super.key});

  @override
  State<MeuAplicativo> createState() => _MeuAplicativoState();
}

class _MeuAplicativoState extends State<MeuAplicativo> {
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  void checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool('onboarding_done');
    setState(() {
      isFirstTime = onboardingDone == null ? true : !onboardingDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            color: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        title: 'Carrabicho',
        initialRoute: '/splash',
        routes: {
          '/': (context) => const AuthCheck(),
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => HomePage(),
          '/forgot_password': (context) => const ForgotPasswordPage(),
          '/signup': (context) => GeneralSignUp(),
          // '/signup3': (context) => SignUpPage3(),
          '/onboarding': (context) => OnBoardingPage(),
          '/bottomnav': (context) => BottomNavScreen(),  
        },
      ),
    );
  }
}
