import 'package:Carrrabicho/models/profissinal.dart';
import 'package:flutter/material.dart';

import '../../../constants/globalvariable.dart';
import '../../agendamentos/screens/agendamento_detalhe.dart';

class ProfissionalDetalhes extends StatefulWidget {
  final ResultProfissional profissional;

  ProfissionalDetalhes({Key? key, required this.profissional}) : super(key: key);

  @override
  State<ProfissionalDetalhes> createState() => _ProfissionalDetalhesState();
}

class _ProfissionalDetalhesState extends State<ProfissionalDetalhes> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.profissional.id);
  }
  
  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          centerTitle: true,
          title: Text('${widget.profissional.nome!} ${widget.profissional.sobrenome!}',),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Valor da consulta:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            Text(
              'R\$ ${widget.profissional.valor}.00',
              style: TextStyle(fontSize: 24, color: Colors.green[300]),
            ),
            SizedBox(height: 20),
            Text(
              'Endereço:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '${widget.profissional.endereco}, ${widget.profissional.bairro}, ${widget.profissional.cidade}, ${widget.profissional.uf}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'E-mail:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  widget.profissional.email!,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Telefone:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  widget.profissional.telefone!,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(18),
              ),
              
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgendamentoDetalhe(profissional: widget.profissional,),
                  ),
                );
              },
              child: Text(
                
                'Agendar',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(18),
                backgroundColor: Colors.green,
              ),
              onPressed: () {},
              child: Text(
                'Iniciar Conversa',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
