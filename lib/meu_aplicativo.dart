import 'package:Carrrabicho/commmon/widgets/bottom_nav_screen.dart';
import 'package:Carrrabicho/providers/user.provider.dart';
import 'package:Carrrabicho/routes.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:Carrrabicho/features/auth/screens/forgot_password_page.dart';
import 'package:Carrrabicho/features/auth/screens/login_page.dart';
import 'package:Carrrabicho/features/auth/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/services/auth_service.dart';

class MeuAplicativo extends StatefulWidget {
  MeuAplicativo({super.key});

  @override
  State<MeuAplicativo> createState() => _MeuAplicativoState();
}

class _MeuAplicativoState extends State<MeuAplicativo> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user.token;
    print(user);
    return MaterialApp(
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
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: Provider.of<UserProvider>(context).user.token!.isNotEmpty
            ? SplashScreen()
            : LoginPage());
  }
}
