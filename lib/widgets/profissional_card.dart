import 'package:Carrrabicho/screens/profissional_detalhes.dart';
import 'package:flutter/material.dart';

import '../models/profissional.dart';

class ProfissionalCard extends StatefulWidget {
  Profissional profissional;

  ProfissionalCard({Key? key, required this.profissional}) : super(key: key);

  @override
  State<ProfissionalCard> createState() => _ProfissionalCardState();
}

class _ProfissionalCardState extends State<ProfissionalCard> {
  abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfissionalDetalhes(profissional: widget.profissional),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => abrirDetalhes(),
        child: Stack(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
            ),
            Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(widget.profissional.foto,
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              widget.profissional.nome,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Local: ${widget.profissional.localizacao}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'R\$: ${widget.profissional.preco}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.red[500]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: SizedBox(
                    //     width: 200,
                    //     child: LinearProgressIndicator(
                    //       color: Colors.white,
                    //       value: ((widget.quantidade > 0)
                    //           ? (widget.nivel / widget.quantidade)
                    //           : 1),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     'Feito: ${widget.nivel}',
                    //     style: const TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    // ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
