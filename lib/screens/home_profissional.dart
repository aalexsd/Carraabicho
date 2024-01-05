import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../bloc/wsf_param.dart';
import '../models/result_pessoa.dart';

class ProfissionalHomeScreen extends StatefulWidget {
  @override
  _ProfissionalHomeScreenState createState() => _ProfissionalHomeScreenState();
}

class _ProfissionalHomeScreenState extends State<ProfissionalHomeScreen> {
  int atendimentosRealizados = 50; // Substitua pela lógica real de contagem de atendimentos
    List<Map<String, dynamic>> agendamentos = [];


    @override
  void initState() {
    super.initState();
    // Chame a função para carregar os agendamentos ao inicializar o widget
    loadAgendamentos();
  }

  // Função para carregar os agendamentos do servidor
  void loadAgendamentos() async {
    try {
      final response = await getAgendamento();
      if (response.statusCode == 200) {
        // Decodifica o corpo da resposta JSON
        final List<dynamic> agendamentosData = json.decode(response.body);

        // Mapeia os dados recebidos para a lista de agendamentos
        List<Map<String, dynamic>> agendamentosList =
            List<Map<String, dynamic>>.from(agendamentosData);

        setState(() {
          agendamentos = agendamentosList;
        });
      } else {
        // Se a requisição não foi bem-sucedida, trata o erro
        print('Erro ao carregar agendamentos: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao carregar agendamentos: $error');
    }
  }

  static Future<http.Response> getAgendamento() async {
    return await http.get(
      user.isUsuario == 'S' ?
      Uri.parse(
        Wsf().baseurl() + 'agendamentos/usuario/${user.id}')
        :      Uri.parse(
        Wsf().baseurl() + 'agendamentos/profissional/${user.id}')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Bem-vindo, ${user.nome}'),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Você tem ${agendamentos.length} atendimento(s) agendado(s).',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
