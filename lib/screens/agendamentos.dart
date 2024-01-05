import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../bloc/wsf_param.dart';
import '../models/result_pessoa.dart';

class AgendamentosScreen extends StatefulWidget {
  final int idUsuario;
  const AgendamentosScreen({super.key, required this.idUsuario});

  @override
  State<AgendamentosScreen> createState() => _AgendamentosScreenState();
}

class _AgendamentosScreenState extends State<AgendamentosScreen> {
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
        title: Text('Meus Agendamentos'),
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: agendamentos.length,
        itemBuilder: (context, index) {
          DateTime dataAgendamento =
              DateTime.parse(agendamentos[index]['data']);
          String dataFormatada =
              DateFormat('dd/MM/yyyy').format(dataAgendamento);

          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.lightBlueAccent, // Cor de fundo
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    agendamentos[index]['titulo'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white), // Cor do texto
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Profissional: ${agendamentos[index]['nomeProfissional']}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Pet: ${agendamentos[index]['pet']}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Data: ${dataFormatada}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Hora: ${agendamentos[index]['hora']}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
