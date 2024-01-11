import 'package:Carrrabicho/screens/agendamentos.dart';
import 'package:Carrrabicho/screens/pets_screen.dart';
import 'package:Carrrabicho/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../models/result_pessoa.dart';
import 'faturamento_screen.dart';
import 'home_display_screen.dart';
import 'home_profissional.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  List<Widget> _getScreens(bool isUsuario) {
    return [
      (isUsuario) ? HomeDisplayScreen() : ProfissionalHomeScreen(),
      (isUsuario) ? PetsScreen() : FaturamentoScreen(),
      if (isUsuario) AgendamentosScreen(idUsuario: user.id!),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isUsuario = user.isUsuario == 'S';
    List<Widget> _screens = _getScreens(isUsuario);

    return Scaffold(
      body: _screens[_currentIndex],
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
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text("Início"),
            selectedColor: Colors.white,
            activeIcon: Icon(Icons.home, color: Colors.white),
          ),
          if (isUsuario)
            SalomonBottomBarItem(
              icon: const Icon(Icons.pets_outlined),
              title: const Text("Pets"),
              selectedColor: Colors.white,
              activeIcon: Icon(Icons.pets, color: Colors.white),
            )
          else
            SalomonBottomBarItem(
              icon: const Icon(Icons.attach_money_outlined),
              title: const Text("Faturamento"),
              selectedColor: Colors.white,
              activeIcon: Icon(Icons.attach_money, color: Colors.white),
            ),
          if (isUsuario)
            SalomonBottomBarItem(
              icon: const Icon(Icons.calendar_month_outlined),
              title: const Text("Agendamentos"),
              selectedColor: Colors.white,
              activeIcon: Icon(Icons.calendar_month, color: Colors.white),
            ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text("Perfil"),
            selectedColor: Colors.white,
            activeIcon: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
