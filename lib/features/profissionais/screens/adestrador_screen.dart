import 'dart:convert';
import 'dart:math';
import 'package:Carrrabicho/features/profissionais/services/profissional_service.dart';
import 'package:Carrrabicho/features/profissionais/widgets/profissional_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:http/http.dart' as http;
import '../../../constants/globalvariable.dart';
import '../../../models/profissinal.dart';

class AdestradorScreen extends StatefulWidget {
  const AdestradorScreen({super.key});

  @override
  State<AdestradorScreen> createState() => _AdestradorScreenState();
}

class _AdestradorScreenState extends State<AdestradorScreen> {
  List<Map<String, dynamic>> vets = [];
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  Future<void> _getVeterinarios() async {
    final response = await http
        .get(Uri.parse('$uri/profissionais/Adestrador'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        vets = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Falha ao carregar profissionais');
    }
  }

  @override
  void initState() {
    super.initState();
    _getVeterinarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          centerTitle: true,
          title: const Text('Adestradores'),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Exibir os profissionais de alguma forma
          Expanded(child: _vets(context)),
        ],
      ),
    );
  }

  _vets(context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(
        thickness: 2.0,
      ),
      itemCount: vets.length,
      itemBuilder: (context, index) {
        final profissional = vets[index];
        return ProfissionalCard(
          profissional: ResultProfissional(
            id: profissional['_id'],
            nome: profissional['nome'],
            sobrenome: profissional['sobrenome'],
            email: profissional['email'],
            telefone: profissional['telefone'],
            endereco: profissional['endereco'],
            bairro: profissional['bairro'],
            cidade: profissional['cidade'],
            uf: profissional['uf'],
            valor: profissional['valor'],
          ),
        );
      },
    );
  }
}
