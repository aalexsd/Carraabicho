import 'package:Carrrabicho/commmon/widgets/custom_button.dart';
import 'package:Carrrabicho/features/profile/widgets/below_appbar.dart';
import 'package:Carrrabicho/features/auth/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../constants/globalvariable.dart';
import '../../../models/user.dart';
import '../../../providers/user.provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final mediaquery = MediaQuery.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text('Perfil'),
          actions: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                width: 80,
                height: 35,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BelowAppBar(),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 20),
            child: Text(
              'Informações Pessoais',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Nome completo:',
                      style: TextStyle(fontSize: 15)),
                  trailing: Text("${user.nome} ${user.sobrenome}" ?? ''),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text(
                    'E-mail:',
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Text(user.email!),
                ),
                const Divider(height: 1),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomButtom(
                child: Text("Editar Perfil"),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: OutlinedButton(
              onPressed: () {
                sair(context);
              },
              style: ElevatedButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.red,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sair do App',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  sair(BuildContext context) {
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
