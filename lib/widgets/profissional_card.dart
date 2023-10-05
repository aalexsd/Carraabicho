import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/profissional.dart';

class ProfissionalCard extends StatefulWidget {
  Profissional profissional;

  ProfissionalCard({Key? key, required this.profissional}) : super(key: key);

  @override
  _ProfissionalCardState createState() => _ProfissionalCardState();
}

class _ProfissionalCardState extends State<ProfissionalCard> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  static Map<String, Color> precoColor = <String, Color>{
    'up': Colors.teal,
    'down': Colors.indigo,
  };

  // abrirDetalhes() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => MoedasDetalhes(moeda: widget.moeda),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
          child: Row(
            children: [
              SizedBox(
                child: Image.asset(
                  widget.profissional.foto,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.profissional.nome,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.profissional.localizacao,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: precoColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: precoColor['down']!.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  real.format(widget.profissional.preco),
                  style: TextStyle(
                    fontSize: 16,
                    color: precoColor['down'],
                    letterSpacing: -1,
                  ),
                ),
              ),
              // PopupMenuButton(
              //   icon: const Icon(Icons.more_vert),
              //   itemBuilder: (context) => [
              //     PopupMenuItem(
              //       child: ListTile(
              //         title: const Text('Remover das Favoritas'),
              //         onTap: () {
              //           Navigator.pop(context);
              //           Provider.of<FavoritasRepository>(context, listen: false)
              //               .remove(widget.moeda);
              //         },
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
