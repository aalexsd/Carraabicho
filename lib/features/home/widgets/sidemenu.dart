import 'package:Carrrabicho/features/profile/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../commmon/widgets/chat.page.dart';
import '../../auth/screens/login_page.dart';
import '../payment_screen.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                ),
              );
            },
            title: Row(
              children: [
                Icon(Icons.chat),
                SizedBox(
                  width: 10,
                ),
                Text('Fale conosco'),
              ],
            ),
          ),
                    ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(),
                ),
              );
            },
            title: Row(
              children: [
                Icon(Icons.credit_card),
                SizedBox(
                  width: 10,
                ),
                Text('Pagamento'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              sair(context);
              // signOutGoogle().then((value) =>   Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => LoginPage()),
              // ));
              // FirebaseAuth.instance.signOut();
            },
            child: ListTile(
              title: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Sair'),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout realizado com sucesso')),
    );
  }

    sair(BuildContext context) {
    // var bloc = Provider.of<UserBloc>(context);
    //var res = await bloc.create(user);

    if (true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }
}
