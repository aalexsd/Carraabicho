import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/result_pessoa.dart';

class GeneralSignUp extends StatefulWidget {
  const GeneralSignUp({super.key});

  @override
  State<GeneralSignUp> createState() => _GeneralSignUpState();
}

class _GeneralSignUpState extends State<GeneralSignUp> {
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final telefone = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 10),
          child: TextFormField(
            controller: nome,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
              hintText: 'Digite seu Nome',
              labelText: 'Nome',
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informe seu nome corretamente!';
              }
              return null;
            },
            onChanged: (value){
              setState(() {
                user.nome = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 12),
          child: TextFormField(
            controller: email,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.app_registration),
              hintText: 'Digite seu CPF',
              labelText: 'CPF',
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informe o CPF!';
              }
              return null;
            },
            onChanged: (value){
              setState(() {
                user.cpf = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 12),
          child: TextFormField(
            inputFormatters: [
              // obrigatório
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter(),
            ],
            keyboardType: TextInputType.phone,
            controller: telefone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
              hintText: 'Digite seu Telefone',
              labelText: 'Telefone',
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informa seu telefone!';
              }
              return null;
            },
            onChanged: (value){
              setState(() {
                user.senha = value;
              });
            },
          ),
        ),
      ],
    );
  }
  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

}
