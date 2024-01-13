import 'dart:convert';
import 'package:Carrrabicho/features/profissionais/widgets/payment_widget.dart';
import 'package:Carrrabicho/features/home/widgets/sidemenu.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../constants/globalvariable.dart';

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
    // loadAgendamentos();
  }

  // Função para carregar os agendamentos do servidor
  // void loadAgendamentos() async {
  //   try {
  //     final response = await getAgendamento();
  //     if (response.statusCode == 200) {
  //       // Decodifica o corpo da resposta JSON
  //       final List<dynamic> agendamentosData = json.decode(response.body);

  //       // Mapeia os dados recebidos para a lista de agendamentos
  //       List<Map<String, dynamic>> agendamentosList =
  //           List<Map<String, dynamic>>.from(agendamentosData);

  //       setState(() {
  //         agendamentos = agendamentosList;
  //       });
  //     } else {
  //       // Se a requisição não foi bem-sucedida, trata o erro
  //       print('Erro ao carregar agendamentos: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Erro ao carregar agendamentos: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          centerTitle: true,
          title: const Text('Faturamento'),
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
                    amount: 'R\$ 5',
                  ),
                ),
              ),
            );
          }),
    );
  }
}
