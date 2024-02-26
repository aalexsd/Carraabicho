import 'dart:convert';

import 'package:Carrrabicho/commmon/widgets/custom_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../commmon/widgets/alert.dart';
import '../../../constants/globalvariable.dart';
import '../../../models/user.dart';
import '../../../commmon/widgets/bottom_nav_screen.dart';
import '../../../providers/user.provider.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        
          title: const Text('Adicionar Pet'),
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
              CustomButtom(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
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
    final user = Provider.of<UserProvider>(context, listen: false).user;

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
        Uri.parse('$uri/pets'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavScreen()));
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Show!',
            message: 'Pet adicionado com sucesso!',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,
            inMaterialBanner: true,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        print(data);
      } else {
        print(response.statusCode);
        showAlertDialog1ok(context, 'Erro ao verificar usuário.');
      }
    } catch (error) {
      print(error);
      showAlertDialog1ok(context, 'Erro interno.');
    } finally {}
  }
}
