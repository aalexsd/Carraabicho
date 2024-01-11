import 'package:Carrrabicho/screens/login_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo[300],
        title: Center(
          child:
          Image.asset("assets/images/logo.png", height: 50, width: 50),
        ),
      ),
      body: Center(
        child: SizedBox(
      width: 300.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 30.0,
          fontFamily: 'Agne',
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText('Carrabicho', textAlign: TextAlign.center),
            TypewriterAnimatedText('O seu pet, nossa paixão', textAlign: TextAlign.center),
            TypewriterAnimatedText('Dando vida e amor aos seus amigos peludos', textAlign: TextAlign.center),
            TypewriterAnimatedText('Inovação que faz o rabinho balançar', textAlign: TextAlign.center),
          ],
          isRepeatingAnimation: false,
          onFinished: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
        ),
      ),
    );
  }
}
