import 'package:Carrrabicho/models/profissional.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class ProfissionalDetalhes extends StatefulWidget {
  Profissional profissional;

  ProfissionalDetalhes({super.key, required this.profissional});

  @override
  State<ProfissionalDetalhes> createState() => _ProfissionalDetalhesState();
}

class _ProfissionalDetalhesState extends State<ProfissionalDetalhes> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _formKey = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;

  comprar() {
    if (_formKey.currentState!.validate()) {
      //Salvar Compra

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compra realizada com sucesso.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profissional.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenW * .8,
                    height: screenH * .35,
                    child: Image.asset(widget.profissional.foto,
                    fit: BoxFit.cover,),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Text("Valor da consulta: " +
              real.format(widget.profissional.preco),
              style: TextStyle(
                  fontSize: 26,
                  letterSpacing: -1,
                  color: Colors.grey[800]),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Localização: " +
              widget.profissional.localizacao,
              style: TextStyle(
                  fontSize: 18,
                  letterSpacing: -1,
                  color: Colors.grey[800]),
            ),
            // (quantidade > 0)
            //     ? SizedBox(
            //   width: screenW,
            //   child: Container(
            //     margin: const EdgeInsets.only(bottom: 24),
            //     // padding: EdgeInsets.all(12),
            //     alignment: Alignment.center,
            //     child: Text(
            //       '$quantidade ${widget.profissional.localizacao}',
            //       style:
            //       const TextStyle(fontSize: 20, color: Colors.teal),
            //     ),
            //     // decoration: BoxDecoration(
            //     //   color: Colors.teal.withOpacity(0.05)
            //     // ),
            //   ),
            // )
            //     : Container(
            //   margin: const EdgeInsets.only(bottom: 24),
            // ),
            SizedBox(
              height: 20,
            ),
            // Form(
            //   key: _formKey,
            //   child: TextFormField(
            //     controller: _valor,
            //     style: const TextStyle(fontSize: 22),
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'Valor',
            //       prefixIcon: Icon(Icons.monetization_on_outlined),
            //       suffix: Text(
            //         'reais',
            //         style: TextStyle(fontSize: 14),
            //       ),
            //     ),
            //     keyboardType: TextInputType.number,
            //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return 'Informe o valor da compra.';
            //       } else if (double.parse(value) < 50) {
            //         return 'Compra mínima é R\$ 50,00';
            //       }
            //       return null;
            //     },
            //     onChanged: (value) {
            //       setState(() {
            //         quantidade = (value.isEmpty)
            //             ? 0
            //             : double.parse(value) / widget.profissional.preco;
            //       });
            //     },
            //   ),
            // ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 24),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenW * .5,
                      child: ElevatedButton(
                          onPressed: () {
                            comprar();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Reservar',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: screenW * .5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green
                        ),
                          onPressed: () {
                            comprar();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Iniciar conversa',
                              style: TextStyle(fontSize: 18),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
