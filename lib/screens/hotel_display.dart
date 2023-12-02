import 'dart:math';
import 'package:Carrrabicho/models/profissional.dart';
import 'package:Carrrabicho/repository/profissoes.dart';
import 'package:Carrrabicho/widgets/profissional_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  int currentIndex = 0;
  final controller = SwipableStackController();
  final tabela = HotelRepository.tabela;
  var imageList = [
    'assets/images/cuidadorbonito.avif',
    'assets/images/cuidadorbonito.avif',
    'assets/images/cuidadorbonito.avif',
    'assets/images/cuidadorbonito.avif',
  ];
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoteis'),
        elevation: 1,
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int profissao) {
          final profissional = tabela[profissao];
          return ProfissionalCard(profissional: profissional);
        },
        padding: const EdgeInsets.all(10),
        separatorBuilder: (_, __) => const Divider(
          thickness: 5.0,
        ),
        itemCount: tabela.length,
      ),
    );
  }
}

// Stack(
// children: [
// SizedBox(
// height: MediaQuery.of(context).size.height * .7,
// width: MediaQuery.of(context).size.width,
// child: SwipableStack(
// overlayBuilder: (context, properties) {
// final opacity = min(properties.swipeProgress, 1.0);
// final isRight = properties.direction == SwipeDirection.right;
// return Opacity(
// opacity: isRight ? opacity : 0,
// );
// },
// controller: controller,
// itemCount: imageList.length,
// builder: (context, properties) {
// return Image.asset(
// imageList[properties.index],
// fit: BoxFit.cover,
// );
// },
// onSwipeCompleted: (index, direction) {
// setState(() {
// if (direction == SwipeDirection.right ||
// direction == SwipeDirection.left) {
// currentIndex++;
// }
// });
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(left: 22.0, bottom: 50),
// child: Align(
// alignment: Alignment.bottomLeft,
// child: FloatingActionButton(
// backgroundColor: Colors.red,
// onPressed: () => controller.rewind(),
// tooltip: 'Rewind',
// child: const Icon(FontAwesomeIcons.x),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(right: 22.0, bottom: 50),
// child: Align(
// alignment: Alignment.bottomRight,
// child: FloatingActionButton(
// backgroundColor: Colors.green[700],
// onPressed: () => controller.currentIndex = 0,
// tooltip: 'reset',
// child: const Icon(FontAwesomeIcons.solidHeart),
// ),
// ),
// ),
// ],
// ),
