import 'package:Carrrabicho/features/auth/screens/login_page.dart';
import 'package:Carrrabicho/features/auth/screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SplashScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      body: Stack(
          children: [
      Container(
      decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/onboardingBG.png'),
      fit: BoxFit.cover,
    ),
    ),
    ),
    IntroductionScreen(
    key: introKey,
    globalBackgroundColor: Colors.transparent,
    allowImplicitScrolling: false,
    autoScrollDuration: 9000,
    infiniteAutoScroll: false,
    pages: [
    PageViewModel(
    title: "Quem Somos",
    body:
    "Nós somos apaixonados por pets! Nosso aplicativo é o lugar onde os amantes de animais de estimação se encontram para encontrar os melhores serviços para seus companheiros peludos.",
    image: _buildImage('logo.png'),
    decoration: pageDecoration,
    ),
    PageViewModel(
    title: "Encontre o Melhor para Seu Pet",
    body:
    "Descubra serviços de qualidade para o seu pet com facilidade. Seja um veterinário atencioso, um cuidador carinhoso, um adestrador habilidoso ou um hotel que mimará seu amigo peludo.",
    image: _buildImage('logo.png'),
    decoration: pageDecoration,
    ),
    PageViewModel(
    title: "Cuide do Seu Melhor Amigo",
    body:
    "Nossa missão é ajudar você a manter seu pet saudável e feliz. Conecte-se com os melhores profissionais e ofereça o melhor cuidado para o seu pet.",
    image: _buildImage('logo.png'),
    decoration: pageDecoration,
    ),
    ],
    onDone: () => _onIntroEnd(context),
    onSkip: () => _onIntroEnd(context), // You can override onSkip callback
    showSkipButton: true,
    skipOrBackFlex: 0,
    nextFlex: 0,
    showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back, color: Colors.white,),
      skip: const Text('Pular', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      next: const Icon(Icons.arrow_forward, color: Colors.white,),
      done: const Text('Feito', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
    color: Color.fromRGBO(204, 211, 250, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    )
  ])
    );
  }
}
