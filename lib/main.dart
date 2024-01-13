import 'dart:io';

import 'package:Carrrabicho/meu_aplicativo.dart';
import 'package:Carrrabicho/providers/user.provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // if (Platform.isIOS) {
  //   await Firebase.initializeApp(
  //       options: FirebaseOptions(
  //           apiKey: "AIzaSyBdJIJrq1s-uKAELE645-q12SakkhpdFo8",
  //           appId: "1:460612349374:ios:0d373616def2bf40ea9def",
  //           messagingSenderId: "460612349374",
  //           projectId: "carrabicho-projeto"));
  // } else {
  //   await Firebase.initializeApp();
  // }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MeuAplicativo(),
    ),
  );
}
