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

  // Controller will help us move next, rewind action

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: const Text(
                    'O que você está procurando hoje?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  1 == 1
                      ? Row(
                          children: [
                            _loadingEcom
                                ? Container(
                                    height: screenHeight / 6,
                                    width: screenW / 2 - 28,
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VeterinarioScreen()),
                                      );
                                    },
                                    child: Container(
                                        height: screenHeight / 6,
                                        width: screenW / 2 - 28,
                                        // margin:
                                        //     EdgeInsets.symmetric(horizontal: 3),
                                        // padding: const EdgeInsets.all(5.0),
                                        // decoration: BoxDecoration(
                                        //   color: Colors.grey.shade300,
                                        //   borderRadius: BorderRadius.all(
                                        //       Radius.circular(5.0)),
                                        // ),

                                        margin: EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/.avif',
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            color: Colors.indigo,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            )),
                                        child: Center(
                                          child: Text(
                                            'Veterinários',
                                            style: TextStyle(fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                          ),
                                        )),
                                  ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CuidadorScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                  height: screenHeight / 6,
                                  width: screenW / 2 - 28,
                                  margin: EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(

                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      )),
                                  child: Center(
                                    child: Text(
                                      'Cuidadores',
                                      style: TextStyle(fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 17,
                              width: 5,
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 150,
                        ),
                  Row(
                    children: [
                      _loadingEcom
                          ? Container(
                              height: screenHeight / 6,
                              width: screenW / 2 - 28,
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdestradorScreen()));
                              },
                              child: Container(
                                  height: screenHeight / 6,
                                  width: screenW / 2 - 28,
                                  margin: EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(

                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      )),
                                  child: Center(
                                    child: Text(
                                      'Adestradores',
                                      style: TextStyle(fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdestradorScreen()));
                        },
                        child: Container(
                            height: screenHeight / 6,
                            width: screenW / 2 - 28,
                            margin: EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )),
                            child: Center(
                              child: Text(
                                'Hotéis',
                                style: TextStyle(fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Fique por dentro!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            ImageCarousel()
          ],
        ));
  }

}
//
