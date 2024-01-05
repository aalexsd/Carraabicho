import 'dart:convert';

import 'package:Carrrabicho/screens/bottom_nav_screen.dart';
import 'package:Carrrabicho/widgets/block_button.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../bloc/wsf_param.dart';
import '../models/result_pessoa.dart';
import '../models/result_profissional.dart';
import '../widgets/alert.dart';

class AgendamentoDetalhe extends StatefulWidget {
  final ResultProfissional profissional;

  AgendamentoDetalhe({Key? key, required this.profissional}) : super(key: key);

  @override
  State<AgendamentoDetalhe> createState() => _AgendamentoDetalheState();
}

class _AgendamentoDetalheState extends State<AgendamentoDetalhe> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController descricaoController = TextEditingController();
    TextEditingController tituloController = TextEditingController();
  bool loading = false;
  final data = TextEditingController();
  final hora = TextEditingController();
  var horaformated;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.profissional.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Agendamento'),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: tituloController,
              decoration: InputDecoration(
                  labelText: ' Nome do agendamento',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: data,
              decoration: InputDecoration(
                  // labelText: ' Data do Agendamento',
                  border: OutlineInputBorder(),
                  hintText: selectedDate == null
                      ? 'Selecione a data'
                      : DateFormat('dd/MM/yyyy').format(selectedDate!),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                ).then((value) {
                  if (value != null && value != selectedDate) {
                    setState(() {
                      selectedDate = value;
                    });
                  }
                });
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: hora,
              decoration: InputDecoration(
                  hintText:
                      horaformated == null ? 'Selecione a data' : horaformated,
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  if (value != null && value != selectedTime) {
                    setState(() {
                      selectedTime = value;
                      String formattedTime =
                          '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}';

                      horaformated = formattedTime;
                    });
                  }
                }).then((value) => print(selectedTime));
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: descricaoController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descrição do serviço',
              ),
            ),
            SizedBox(height: 20),
            BlockButton(
              onPressed: () async {
                await _agendar();
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Agendar',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _agendar() async {
    try {
      if (selectedDate == null || selectedTime == null) {
        // Exibir mensagem de erro se a data ou hora não forem selecionadas
        showAlertDialog1ok(
            context, 'Selecione a data e a hora antes de agendar.');
        return;
      }

      // Formatando a data para "dd/mm/aaaa"
      String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);

      // Formatando a hora para uma string simples "hh:mm"
      String formattedTime =
          '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}';

      var data = {
        "idUsuario": user.id,
        "idProfissional": widget.profissional.id,
        "nomeProfissional": widget.profissional.nome,
        "titulo": tituloController.text,
        "data": formattedDate,
        "hora": formattedTime,
        "descricao": descricaoController.text,
      };

      print(data);

      final response = await http.post(
        Uri.parse(Wsf().baseurl() + 'agendamento'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavScreen()));
        BotToast.showText(
          text: "Agendamento criado com sucesso!",
          textStyle: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w500, color: Colors.white),
          contentColor: Colors.green,
          align: Alignment(0.7, -0.75),
          duration: Duration(seconds: 3),
        ); // N
        print(data);
      } else {
        // Se houver algum problema na requisição, exibir mensagem de erro
        showAlertDialog1ok(context, 'Erro ao verificar usuário.');
      }
    } catch (error) {
      print(error);
      showAlertDialog1ok(context, 'Erro interno.');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
