import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../bloc/wsf_param.dart';
import '../models/result_pessoa.dart';
import 'agendamento_detalhe.dart';

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
    return await http.get(user.isUsuario == 'S'
        ? Uri.parse(Wsf().baseurl() + 'agendamentos/usuario/${user.id}')
        : Uri.parse(Wsf().baseurl() + 'agendamentos/profissional/${user.id}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Meus Agendamentos'),
        elevation: 1,
      ),
      body: 
      
      agendamentos.length == 0
          ? Center(
              child: Text(
                'Poxa, nenhum agendamento encontrado.',
             
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          :
      ListView.builder(
        itemCount: agendamentos.length,
        itemBuilder: (context, index) {
          DateTime dataAgendamento =
              DateTime.parse(agendamentos[index]['data']);
          String dataFormatada =
              DateFormat('dd/MM/yyyy').format(dataAgendamento);
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Slidable(
              key: const ValueKey(0),
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {}),

                // All actions are defined in the children parameter.
                children: const [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Cancelar',
                  ),
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Editar',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: () {_concluir("2");}),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: doNothing,
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.check,
                    label: 'Concluído',
                    autoClose: true,
                  ),
                ],
              ),
              child: FlipCard(
                  fill: Fill
                      .fillBack, // Fill the back side of the card to make in the same size as the front.
                  direction: FlipDirection.HORIZONTAL, // default
                  side: CardSide.FRONT, // The side to initially display.
                  front: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(),

                    color: Colors.lightBlueAccent, // Cor de fundo
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            agendamentos[index]['titulo'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white), // Cor do texto
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
                  ),
                  back: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Colors.lightBlueAccent, // Cor de fundo
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Center(
                        child: Text(
                          "Descrição: ${agendamentos[index]['descricao']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white), // Cor do texto
                        ),
                      ),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}

void doNothing(BuildContext context) {}

void _concluir(String idAgendamento) {
  var url = Uri.parse('http://localhost:8081/agendamentos/$idAgendamento/status');
  var data = {'novoStatus': 1};
  var data2 = json.encode(data);
  var headers = {'Content-Type': 'application/json'};
  http.put(url, body: data2, headers: headers).then((response) {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  });
}
