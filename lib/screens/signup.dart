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
  final cpf = TextEditingController();
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
            controller: cpf,
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
            controller: email, // Adicionado controlador de e-mail
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email), // Alterado ícone para ícone de e-mail
              hintText: 'Digite seu E-mail', // Alterado texto de dica para 'Digite seu E-mail'
              labelText: 'E-mail', // Alterado rótulo para 'E-mail'
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            keyboardType: TextInputType.emailAddress, // Alterado tipo de teclado para TextInputType.emailAddress
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informe o e-mail corretamente!'; // Alterado mensagem de erro para 'Informe o e-mail corretamente!'
              }
              return null;
            },
            onChanged: (value){
              setState(() {
                user.email = value; // Salve o valor na variável user.email
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
                user.celular = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 12),
          child: TextFormField(
            obscureText: !showPassword,
            controller: senha,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              hintText: 'Digite sua Senha',
              labelText: 'Senha',
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              suffixIcon: InkWell(
                onTap: _togglePasswordVisibility,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0,
                      right: 12,
                      bottom: 12),
                  child: Text(
                    showPassword
                        ? 'Ocultar'
                        : 'Exibir',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informe sua senha!';
              } else if (value.length < 6) {
                return 'Sua senha deve ter no mínimo 6 caracteres';
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