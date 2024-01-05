import 'package:flutter/material.dart';
import 'package:Carrrabicho/models/result_profissional.dart';
import 'package:Carrrabicho/screens/profissional_detalhes.dart';

class ProfissionalCard extends StatelessWidget {
  final ResultProfissional profissional;

  ProfissionalCard({Key? key, required this.profissional}) : super(key: key);

  void abrirDetalhes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfissionalDetalhes(profissional: profissional),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => abrirDetalhes(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${profissional.nome!} ${profissional.sobrenome!}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'R\$ ${profissional.valor}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green[500],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Local: ${profissional.bairro}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Contato: ${profissional.telefone}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Endereço: ${profissional.endereco}, ${profissional.cidade} - ${profissional.uf}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Adicione mais detalhes ou elementos conforme necessário
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
