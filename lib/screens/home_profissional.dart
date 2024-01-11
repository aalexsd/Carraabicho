import 'dart:convert';
import 'dart:ffi';
import 'package:Carrrabicho/models/result_agendamento.dart';
import 'package:Carrrabicho/screens/teste.dart';
import 'package:Carrrabicho/widgets/sidemenu.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../bloc/wsf_param.dart';
import '../models/result_pessoa.dart';

class ProfissionalHomeScreen extends StatefulWidget {
  @override
  _ProfissionalHomeScreenState createState() => _ProfissionalHomeScreenState();
}

class _ProfissionalHomeScreenState extends State<ProfissionalHomeScreen> {
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

  Future<bool> myAgendamentos() async {
    final response = await http.get(
      user.isUsuario == 'S'
          ? Uri.parse(Wsf().baseurl() + 'agendamentos/usuario/${user.id}')
          : Uri.parse(Wsf().baseurl() + 'agendamentos/profissional/${user.id}'),
    );
    if (response.statusCode == 200) {
      agendamento = ResultAgendamento.fromJson(jsonDecode(response.body));
      if (user.id! > 0) {
        return true;
      } else
        return false;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Bem-vindo, ${user.nome}'),
        elevation: 1,
      ),
      drawer: Menu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (agendamento.status == 0)
                  ? Center(
                      child: Text(
                        'Você tem ${agendamentos.length} atendimento(s) agendado(s).',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Center(
                      child: Text(
                        'Você não tem atendimento(s) agendado(s).',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: (agendamento.status == 0)
                    ? Row(
                        children: [
                          for (var agendamento in agendamentos)
                            AgendamentoCard(agendamento: agendamento)
                        ],
                      )
                    : Center(
                        child: Text(
                          'Você não tem atendimento(s) agendado(s)\n'
                          'para os próximos dias.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 20),
              Text(
                'Agendamentos por mês',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              AspectRatio(
                aspectRatio: 12 / 9,
                child: DChartBarO(
                  animate: true,
                  groupList: [
                    OrdinalGroup(
                      id: '1',
                      data: [
                        OrdinalData(domain: 'Dez', measure: 0),
                        OrdinalData(
                            domain: 'Jan', measure: agendamentos.length),
                        OrdinalData(domain: 'Fev', measure: 0),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgendamentoCard extends StatelessWidget {
  final Map<String, dynamic> agendamento;

  const AgendamentoCard({Key? key, required this.agendamento})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dataAgendamento = DateTime.parse(agendamento['data']);
    String dataFormatada = DateFormat('dd/MM/yyyy').format(dataAgendamento);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FlipCard(
        fill: Fill.fillBack,
        back: Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.lightBlueAccent, // Cor de fundo
            child: Container(
                width: 250, // Largura do cartão

                padding: EdgeInsets.all(16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        agendamento['descricao'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white, // Cor do texto
                        ),
                      ),
                    ]))),
        front: Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: Colors.lightBlueAccent, // Cor de fundo
          child: Container(
            width: 250, // Largura do cartão
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agendamento['titulo'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // Cor do texto
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(height: 5),
                Text(
                  'Pet: ${agendamento['pet']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  'Data: $dataFormatada',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  'Hora: ${agendamento['hora']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
