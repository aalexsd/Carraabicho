import 'dart:convert';
import 'dart:ffi';
import 'package:Carrrabicho/screens/teste.dart';
import 'package:Carrrabicho/widgets/sidemenu.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../bloc/wsf_param.dart';
import '../models/result_pessoa.dart';

class FaturamentoScreen extends StatefulWidget {
  @override
  _FaturamentoScreenState createState() => _FaturamentoScreenState();
}

class _FaturamentoScreenState extends State<FaturamentoScreen> {
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
      user.isUsuario == 'S'
          ? Uri.parse(Wsf().baseurl() + 'agendamentos/usuario/${user.id}')
          : Uri.parse(Wsf().baseurl() + 'agendamentos/profissional/${user.id}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Faturamento'),
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: agendamentos.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80,
                child: Center(
                  child: PaymentItem(
                    title: agendamentos[index]["descricao"],
                    iconData: Icon(Icons.monetization_on),
                    amount: 'R\$ ${user.valor}',
                  ),
                ),
              ),
            );
          }),
    );
  }
}

