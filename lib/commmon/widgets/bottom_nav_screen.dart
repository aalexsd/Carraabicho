import 'package:Carrrabicho/features/pets/screens/pets_screen.dart';
import 'package:Carrrabicho/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../features/agendamentos/screens/agendamentos.dart';
import '../../features/profissionais/screens/faturamento_screen.dart';
import '../../features/profissionais/screens/home_profissional.dart';
import '../../models/user.dart';
import '../../providers/user.provider.dart';
import '../../features/home/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  static const String routeName = '/bottom-bar';

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    List<Widget> _getScreensUsers() {
      return [
        HomeDisplayScreen(),
        PetsScreen(),
        AgendamentosScreen(idUsuario: user.id!),
        ProfileScreen()
      ];
    }

    List<Widget> _getScreensProf() {
      return [ProfissionalHomeScreen(), FaturamentoScreen(), ProfileScreen()];
    }

    List<SalomonBottomBarItem> itensUsers = [
      SalomonBottomBarItem(
        icon: const Icon(Icons.home_outlined),
        title: const Text("Início"),
        selectedColor: Colors.white,
        activeIcon: Icon(Icons.home, color: Colors.white),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.pets_outlined),
        title: const Text("Pets"),
        selectedColor: Colors.white,
        activeIcon: Icon(Icons.pets, color: Colors.white),
      ),
      SalomonBottomBarItem(
          icon: const Icon(Icons.calendar_month_outlined),
          title: const Text("Agendamentos"),
          selectedColor: Colors.white,
          activeIcon: Icon(Icons.calendar_month, color: Colors.white)),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person_outline),
        title: const Text("Perfil"),
        selectedColor: Colors.white,
        activeIcon: Icon(Icons.person, color: Colors.white),
      ),
    ];

    List<SalomonBottomBarItem> itensProf = [
      SalomonBottomBarItem(
        icon: const Icon(Icons.home_outlined),
        title: const Text("Início"),
        selectedColor: Colors.white,
        activeIcon: Icon(Icons.home, color: Colors.white),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.attach_money_outlined),
        title: const Text("Faturamento"),
        selectedColor: Colors.white,
        activeIcon: Icon(Icons.attach_money, color: Colors.white),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person_outline),
        title: const Text("Perfil"),
        selectedColor: Colors.white,
        activeIcon: Icon(Icons.person, color: Colors.white),
      ),
    ];

    List<Widget> _screensUsers = _getScreensUsers();
    List<Widget> _screensProf = _getScreensProf();

    return Scaffold(
      body: (user.isUsuario == 'S')
          ? _screensUsers[_currentIndex]
          : _screensProf[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.black87,
        margin: const EdgeInsets.all(12.0),
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 9) {
            return;
          } else {
            setState(() => _currentIndex = index);
          }
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          if (user.isUsuario == 'S') ...itensUsers,
          if (user.isUsuario == 'N') ...itensProf,
        ],
      ),
    );
  }
}
