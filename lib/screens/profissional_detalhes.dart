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
                    width: screenW * .1,
                    child: Image.asset(widget.profissional.foto),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    real.format(widget.profissional.preco),
                    style: TextStyle(
                        fontSize: 26,
                        letterSpacing: -1,
                        color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
            (quantidade > 0)
                ? SizedBox(
              width: screenW,
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                // padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text(
                  '$quantidade ${widget.profissional.localizacao}',
                  style:
                  const TextStyle(fontSize: 20, color: Colors.teal),
                ),
                // decoration: BoxDecoration(
                //   color: Colors.teal.withOpacity(0.05)
                // ),
              ),
            )
                : Container(
              margin: const EdgeInsets.only(bottom: 24),
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _valor,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    'reais',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o valor da compra.';
                  } else if (double.parse(value) < 50) {
                    return 'Compra mínima é R\$ 50,00';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    quantidade = (value.isEmpty)
                        ? 0
                        : double.parse(value) / widget.profissional.preco;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                  onPressed: () {
                    comprar();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Comprar',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
