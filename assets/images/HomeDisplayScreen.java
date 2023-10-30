import 'package:Carrrabicho/screens/veterinario_screen.dart';
import 'package:Carrrabicho/widgets/image_carousel.dart';
import 'package:Carrrabicho/widgets/sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'adestrador_screen.dart';
import 'cuidador_display.dart';

class HomeDisplayScreen extends StatefulWidget {
  const HomeDisplayScreen({Key? key}) : super(key: key);

  @override
  State<HomeDisplayScreen> createState() => _HomeDisplayScreenState();
}

class _HomeDisplayScreenState extends State<HomeDisplayScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedValue = 0;
  bool _loadingEcom = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check if the current user's email is verified
  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<void> sendVerificationEmail() async {
    User? user = _auth.currentUser;
    await user?.sendEmailVerification();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white, // Defina a cor de fundo como branca
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(FontAwesomeIcons.bars),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      //creates a side screen
      drawer: Menu(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/seu_background.jpg'), // Substitua 'seu_background.jpg' pelo caminho da sua imagem de fundo
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView( // Use SingleChildScrollView para permitir a rolagem do conteúdo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Resto do conteúdo da tela permanece o mesmo
              // ...
            ],
          ),
        ),
      ),
    );
  }
}
