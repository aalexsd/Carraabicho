import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/globalvariable.dart';
import '../../../models/agendamento.dart';
import '../../../providers/user.provider.dart';
import 'agendamento_detalhe.dart';

class AgendamentosScreen extends StatefulWidget {
  final String idUsuario;
  const AgendamentosScreen({super.key, required this.idUsuario});

  @override
  State<AgendamentosScreen> createState() => _AgendamentosScreenState();
}

class _AgendamentosScreenState extends State<AgendamentosScreen> {
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
        print(value.body);
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

  Future<http.Response> getAgendamento() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return await http.get(user.isUsuario == 'S'
        ? Uri.parse('$uri/agendamentos/usuario/${user.id}')
        : Uri.parse('$uri/agendamentos/profissional/${user.id}'));
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
          title: const Text('Meus agendamentos'),
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
      body: agendamentos.length == 0
          ? Center(
              child: Text(
                'Poxa, nenhum agendamento encontrado.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: agendamentos.length,
              itemBuilder: (context, index) {
                final agendamento = agendamentos[index];
                DateTime? dataAgendamento = agendamento.data != null
                    ? DateTime.parse(agendamento.data!)
                    : null;
                String? dataFormatada = dataAgendamento != null
                    ? DateFormat('dd/MM/yyyy').format(dataAgendamento)
                    : null;
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {
                        showAlertDialog1ok(
                            context,
                            'Deseja cancelar o agendamento?',
                            "${agendamento.id}",
                            nPop: 1,
                            tipo: 1);
                      }),

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
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {
                        _concluir("${agendamento.id}");
                      }),
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
                                  agendamento.titulo!,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white), // Cor do texto
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Profissional: ${agendamento.nomeProfissional!}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  'Pet: ${agendamento.pet!}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Data: ${dataFormatada}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Hora: ${agendamento.hora!}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        back: Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: Colors.lightBlueAccent, // Cor de fundo
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Center(
                              child: Text(
                                "Descrição: ${agendamento.descricao}",
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

  Future<void> showAlertDialog1ok(
      BuildContext context, String mensagem, String idAgendamento,
      {int nPop = 1, int tipo = 0}) async {
    // configura o button
    Widget okButton = CupertinoDialogAction(
      child: Text("Sim"),
      onPressed: () {
        _concluir(idAgendamento);
        int x;
        for (x = 0; x < nPop; x++) Navigator.of(context).pop();
      },
    );
    Widget naoButton = CupertinoDialogAction(
      child: Text("Não"),
      onPressed: () {
        int x;
        for (x = 0; x < nPop; x++) Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    Widget alerta = tipo == 0
        ? CupertinoAlertDialog(
            title: Text('Atenção'),
            content: Text(mensagem),
            actions: [okButton],
          )
        : CupertinoAlertDialog(
            title: Text('Sucesso'),
            content: Text(mensagem),
            actions: [naoButton, okButton],
          );

    // exibe o dialog
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        },
      );
    }
  }
}

void doNothing(BuildContext context) {}

void _concluir(String idAgendamento) {
  var url =
      Uri.parse('http://localhost:8081/agendamentos/$idAgendamento/status');
  var data = {'novoStatus': 1};
  var data2 = json.encode(data);
  print(data2);
  print(idAgendamento);
  var headers = {'Content-Type': 'application/json'};
  http.put(url, body: data2, headers: headers).then((response) {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  });
}
