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
  List<ResultAgendamento> agendamentos = [];
  List<ResultAgendamento> agendamentosAtivos = [];

  @override
  void initState() {
    super.initState();
    // Chame a função para carregar os agendamentos ao inicializar o widget
    loadAgendamentos();
  }

  // Função para carregar os agendamentos do servidor
  void loadAgendamentos() async {
    try {
      final response = await getAgendamento().then((value) {
        // print(value.body);
        if (mounted) {
          setState(() {
            Iterable list = json.decode(value.body);
            agendamentos =
                list.map((model) => ResultAgendamento.fromJson(model)).toList();
            agendamentosAtivos = list
              .where((agendamento) => agendamento['status'] == false)
              .map((model) => ResultAgendamento.fromJson(model))
              .toList();
              print(agendamentosAtivos.length);
          });
          
        }
      });
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
              Center(
                child: Text(
                  'Você tem ${agendamentosAtivos.length} atendimento(s) agendado(s).',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: Row(
                    children: [
                      for (var agendamento in agendamentosAtivos)
                        AgendamentoCard(agendamento2: agendamento),
                    ],
                  )),
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
  final ResultAgendamento agendamento2;

  const AgendamentoCard({Key? key, required this.agendamento2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? dataAgendamento = agendamento2.data != null
        ? DateTime.parse(agendamento2.data!)
        : null;

    String? dataFormatada = dataAgendamento != null
        ? DateFormat('dd/MM/yyyy').format(dataAgendamento)
        : null;

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
                  agendamento2.descricao ?? '', // Use ?? to provide a default value
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // Cor do texto
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  agendamento2.titulo ?? '', // Use ?? to provide a default value
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // Cor do texto
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(height: 5),
                Text(
                  'Pet: ${agendamento2.pet ?? ''}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  'Data: ${dataFormatada ?? ''}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  'Hora: ${agendamento2.hora ?? ''}',
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
