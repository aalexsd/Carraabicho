import 'dart:convert';

import 'package:Carrrabicho/screens/signup_page2.dart';
import 'package:Carrrabicho/widgets/block_button.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../bloc/wsf_param.dart';
import '../models/result_pessoa.dart';
import '../widgets/alert.dart';

class GeneralSignUp extends StatefulWidget {
  const GeneralSignUp({super.key});

  @override
  State<GeneralSignUp> createState() => _GeneralSignUpState();
}

class _GeneralSignUpState extends State<GeneralSignUp> {
  final nome = TextEditingController();
  final sobrenome = TextEditingController();
  final cpf = TextEditingController();
  final telefone = TextEditingController();
  bool _loading = false;
  bool showPassword = false;
  var _nome = '';
  var _sobrenome = '';
  var _cpf = '';
  var _nasc = '';
  var _telefone = '';
  final formKey = GlobalKey<FormState>();
  int _msexo = 0;
  var sexo = '';

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/loginBG.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenH * .05,
                  ),
                  SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      )),
                  Center(
                    child: Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        width: screenW * .88,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        child: Column(
                          children: [
                            Text(
                              "Registre-se",
                              style: const TextStyle(
                                color: Colors.indigo,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1.5,
                              ),
                            ),
                            Text(
                              "Crie sua conta",
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -1),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: TextFormField(
                                    controller: nome,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Digite seu Nome',
                                      labelText: 'Nome',
                                    ),
                                    onSaved: (val) {
                                      _nome = val!;
                                    },
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Informe seu nome corretamente!';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        user.nome = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: TextFormField(
                                    controller: sobrenome,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.person_outline),
                                      hintText: 'Digite seu Sobrenome',
                                      labelText: 'Sobrenome',
                                    ),
                                    onSaved: (val) {
                                      _sobrenome = val!;
                                    },
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Informe seu sobrenome!';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        user.nome = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: TextFormField(
                                    controller: cpf,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.app_registration),
                                      hintText: 'Digite seu CPF',
                                      labelText: 'CPF',
                                    ),
                                    onSaved: (val) {
                                      _cpf = val!;
                                    },
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
                                    onChanged: (value) {
                                      setState(() {
                                        user.cpf = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
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
                                    ),
                                    onSaved: (val) {
                                      _telefone = val!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Informa seu telefone!';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        user.celular = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 10, right: 10),
                              child: TextFormField(
                                inputFormatters: [
                                  // obrigatório
                                  FilteringTextInputFormatter.digitsOnly,
                                  DataInputFormatter(),
                                ],
                                validator: (String? value) {
                                  if (valueValidator(value)) {
                                    return 'Informe sua Data de Nascimento';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Data de nascimento',
                                  labelText: 'Data de nascimento',
                                  border: OutlineInputBorder(),
                                ),
                                onSaved: (newValue) => _nasc = newValue!,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "Sexo",
                                      style: TextStyle(
                                        // color: Color(int.parse('0xFF' + myCustom.cor4)),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  CustomRadioButton(
                                      enableShape: true,
                                      autoWidth: true,
                                      elevation: 0,
                                      absoluteZeroSpacing: false,
                                      unSelectedColor:
                                          Theme.of(context).canvasColor,
                                      buttonLables: [
                                        'Masculino',
                                        'Feminino',
                                      ],
                                      buttonValues: [
                                        "MASCULINO",
                                        "FEMININO",
                                      ],
                                      buttonTextStyle: ButtonTextStyle(
                                          selectedColor: Colors.white,
                                          unSelectedColor: Colors.black,
                                          textStyle: TextStyle(fontSize: 16)),
                                      radioButtonValue: (value) {
                                        if (value == "MASCULINO") {
                                          setState(() {
                                            sexo = "M";
                                          });
                                        } else {
                                          setState(() {
                                            sexo = "F";
                                          });
                                        }
                                      },
                                      selectedColor: Colors.indigo),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, ),
                              child: BlockButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    setState(() {
                                      _loading = true;
                                    });
                                    if (CPFValidator.isValid(_cpf)) {
                                      _verifyUser();
                                    } else {
                                      showAlertDialog1ok(context,
                                          'CPF inválido, tente novamente.');
                                      setState(() {
                                        _loading = false;
                                      });
                                    }
                                  }
                                },
                                child: _loading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Prosseguir',
                                        style: TextStyle(fontSize: 20),
                                      ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                "Voltar ao login",
                                style: const TextStyle(color: Colors.indigo),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  create1(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpPage2(
          nome: _nome,
          sobrenome: _sobrenome,
          cpf: _cpf.toString().replaceAll(".", "").replaceAll("-", ""),
          telefone: _telefone,
          nasc: _nasc,
          sexo: sexo,
        ), //ResetPasswordPage(),
      ),
    );
    setState(() {
      _loading = false;
    });
  }

  Future<void> _verifyUser() async {
    try {
      final response = await http.post(
        Uri.parse(Wsf().baseurl() +
            'verificar-usuario'), // Substitua pelo endereço correto da sua API
        body: jsonEncode({
          'cpf': _cpf.replaceAll(".", "").replaceAll("-", ""),
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['exists']) {
          // Usuário já cadastrado, exibir mensagem
          showAlertDialog1ok(context, data['message']);
        } else {
          await create1(context);
        }
      } else {
        // Se houver algum problema na requisição, exibir mensagem de erro
        showAlertDialog1ok(context, 'Erro ao verificar usuário.');
      }
    } catch (error) {
      print(error);
      showAlertDialog1ok(context, 'Erro interno.');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }
}