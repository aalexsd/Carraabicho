import 'package:Carrrabicho/screens/edit_profile_screen.dart';
import 'package:Carrrabicho/screens/login_page.dart';
import 'package:Carrrabicho/widgets/block_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../Services/auth_services.dart';
import '../models/result_pessoa.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String displayName =
      FirebaseAuth.instance.currentUser?.displayName ?? '';

  void updateDisplayName(String newName) {
    setState(() {
      displayName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Olá, ${user.nome}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                                updateDisplayName: updateDisplayName,
                                displayName: displayName,
                              )));
                    },
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
                child: BlockButton(
                  child: Text("Editar Perfil"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/bluetooth');
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: OutlinedButton(
                onPressed: () {
                  // context.read<AuthService>().logout();
                  // signOutGoogle();
                  sair(context);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
      ),
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

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout realizado com sucesso')),
    );
  }

  
}
