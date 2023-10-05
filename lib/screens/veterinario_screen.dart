import 'dart:math';
import 'package:Carrrabicho/repository/profissoes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:swipable_stack/swipable_stack.dart';

class VeterinarioScreen extends StatefulWidget {
  const VeterinarioScreen({super.key});

  @override
  State<VeterinarioScreen> createState() => _VeterinarioScreenState();
}

class _VeterinarioScreenState extends State<VeterinarioScreen> {
  int currentIndex = 0;
  final controller = SwipableStackController();
  final tabela = ProfissionalRepository.tabela;
  var imageList = [
    'assets/images/veterinario1.jpeg',
    'assets/images/veterinario.jpeg',
    'assets/images/veterinario2.jpeg',
    'assets/images/veterinario3.jpeg',
  ];
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veterinários'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int profissao) {
          return ListTile(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            leading: SizedBox(
                child: Image.asset(tabela[profissao].foto,
                height: 200,
                width: 100,)),
            title: Text(
              tabela[profissao].nome,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            subtitle: Text(
              tabela[profissao].localizacao,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            trailing: Text(real.format(tabela[profissao].preco)),
            contentPadding: const EdgeInsets.all(4),

            // selected: selecionadas.contains(tabela[profissao]),
            // selectedTileColor: Colors.indigo[50],
            // onTap: () {
            //   if (selecionadas.isEmpty) {
            //     mostrarDetalhes(tabela[profissao]);
            //   } else {
            //     setState(() {
            //       (selecionadas.contains(tabela[profissao]))
            //           ? selecionadas.remove(tabela[profissao])
            //           : selecionadas.add(tabela[profissao]);
            //     });
            //   }
            // },
            // onLongPress: () {
            //   setState(() {
            //     (selecionadas.contains(tabela[profissao]))
            //         ? selecionadas.remove(tabela[profissao])
            //         : selecionadas.add(tabela[profissao]);
            //   });
            // },
          );
        },
        padding: const EdgeInsets.all(10),
        separatorBuilder: (_, __) => const Divider(
          thickness: 1.0,
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
