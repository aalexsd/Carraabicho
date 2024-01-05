import 'dart:convert';
import 'dart:math';
import 'package:Carrrabicho/data/profissional_service.dart';
import 'package:Carrrabicho/models/profissional.dart';
import 'package:Carrrabicho/repository/profissoes.dart';
import 'package:Carrrabicho/widgets/profissional_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:http/http.dart' as http;
import '../bloc/wsf_param.dart';
import '../models/result_profissional.dart';

class VeterinarioScreen extends StatefulWidget {
  const VeterinarioScreen({super.key});

  @override
  State<VeterinarioScreen> createState() => _VeterinarioScreenState();
}

class _VeterinarioScreenState extends State<VeterinarioScreen> {
  final tabela = VeterinarioRepository.tabela;
  var imageList = [
    'assets/images/veterinario1.jpeg',
    'assets/images/veterinario.jpeg',
    'assets/images/veterinario2.jpeg',
    'assets/images/veterinario3.jpeg',
  ];
  List<Map<String, dynamic>> vets = [];
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  Future<void> _getVeterinarios() async {
    final response = await http
        .get(Uri.parse(Wsf().baseurl() + 'profissionais/Veterinário'));
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
      appBar: AppBar(
        title: Text('Veterinários'),
        elevation: 1,
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
            id: profissional['id'],
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
