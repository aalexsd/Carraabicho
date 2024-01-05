import 'dart:convert';

import 'package:Carrrabicho/widgets/block_button.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../bloc/wsf_param.dart';
import '../models/result_pessoa.dart';
import '../widgets/alert.dart';
import 'bottom_nav_screen.dart';

class AddPetScreen extends StatefulWidget {
  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _nome;
  String? _raca;
  String? _cor;
  double? _peso;
  int? _idade;
  String? _tipoPet;

  List<String> _tiposPet = ['Cachorro', 'Gato', 'Coelho', 'Cobra'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: 'Tipo de Pet', border: OutlineInputBorder()),
                items: _tiposPet.map((tipo) {
                  return DropdownMenuItem(
                    value: tipo,
                    child: Text(tipo),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _tipoPet = value;
                  });
                },
                value: _tipoPet,
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione o tipo de pet.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Nome', border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o nome do pet.';
                  }
                  return null;
                },
                onSaved: (value) => _nome = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Raça', border: OutlineInputBorder()),
                onSaved: (value) => _raca = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Cor', border: OutlineInputBorder()),
                onSaved: (value) => _cor = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Peso', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (value) => _peso = double.parse(value!),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Idade', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (value) => _idade = int.parse(value!),
              ),
              SizedBox(height: 20),
              BlockButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate())  {
                    _formKey.currentState!.save();
                  await _cadastrarPet();
                  }
                },
                child: Text('Adicionar Pet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

_cadastrarPet() async {
    try {

      var data = {
        "idUsuario": user.id,
        "tipoPet": _tipoPet,
        "nomePet": _nome,
        "raca": _raca,
        "cor": _cor,
        "peso": _peso.toString(),
        "idade": _idade.toString(),
      };

      print(data);

      final response = await http.post(
        Uri.parse(Wsf().baseurl() + 'pets'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavScreen()));
        BotToast.showText(
          text: "Pet adicionado com sucesso!",
          textStyle: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w500, color: Colors.white),
          contentColor: Colors.green,
          align: Alignment(0.7, -0.75),
          duration: Duration(seconds: 3),
        ); // N
        print(data);
      } else {
        showAlertDialog1ok(context, 'Erro ao verificar usuário.');
      }
    } catch (error) {
      print(error);
      showAlertDialog1ok(context, 'Erro interno.');
    } finally {

    }
  }

}
