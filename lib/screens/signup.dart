import 'package:flutter/material.dart';

class GeneralSignUp extends StatefulWidget {
  const GeneralSignUp({super.key});

  @override
  State<GeneralSignUp> createState() => _GeneralSignUpState();
}

class _GeneralSignUpState extends State<GeneralSignUp> {
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();

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
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informe seu nome corretamente!';
              }
              return null;
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
              prefixIcon: Icon(Icons.email),
              hintText: 'Digite seu E-mail',
              labelText: 'Email',
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informe o email corretamente!';
              }
              return null;
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
