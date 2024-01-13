import 'dart:convert';

import 'package:Carrrabicho/commmon/widgets/custom_button.dart';
import 'package:Carrrabicho/commmon/widgets/custom_textfield.dart';
import 'package:Carrrabicho/features/auth/screens/signup_page2.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../commmon/widgets/alert.dart';
import '../../../constants/globalvariable.dart';
import '../../../providers/user.provider.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/singup1';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _nascController = TextEditingController();
  bool _loading = false;
  bool showPassword = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
                              offset:
                                  Offset(0, 4), // changes position of shadow
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
                                CustomTextField(
                                    onSaved: () {
                                      setState(() {
                                        user.nome = _nomeController.text;
                                      });
                                      print(user.nome);
                                    },
                                    controller: _nomeController,
                                    hintText: 'Nome'),
                                CustomTextField(
                                    onSaved: () {
                                      setState(() {
                                        user.sobrenome =
                                            _sobrenomeController.text;
                                      });
                                    },
                                    controller: _sobrenomeController,
                                    hintText: 'Sobrenome'),
                                CustomTextField(
                                  onSaved: () {
                                    setState(() {
                                      user.cpf = _cpfController.text;
                                    });
                                  },
                                  controller: _cpfController,
                                  hintText: 'CPF',
                                  keyboardType: TextInputType.number,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CpfInputFormatter(),
                                  ],
                                ),
                                CustomTextField(
                                  onSaved: () {
                                    setState(() {
                                      user.telefone = _telefoneController.text;
                                    });
                                  },
                                  controller: _telefoneController,
                                  hintText: 'Telefone',
                                  keyboardType: TextInputType.phone,
                                  inputFormatter: [
                                    // obrigatório
                                    FilteringTextInputFormatter.digitsOnly,
                                    TelefoneInputFormatter(),
                                  ],
                                ),
                                CustomTextField(
                                  onSaved: () {
                                    setState(() {
                                      user.nasc = _nascController.text;
                                    });
                                  },
                                  controller: _nascController,
                                  hintText: 'Data de nascimento',
                                  keyboardType: TextInputType.number,
                                  inputFormatter: [
                                    // obrigatório
                                    FilteringTextInputFormatter.digitsOnly,
                                    DataInputFormatter(),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 10),
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
                                            user.sexo = "M";
                                          });
                                        } else {
                                          setState(() {
                                            user.sexo = "F";
                                          });
                                        }
                                      },
                                      selectedColor: Colors.indigo),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: CustomButtom(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    setState(() {
                                      _loading = true;
                                    });
                                    if (CPFValidator.isValid(
                                        _cpfController.text)) {
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
                                Navigator.pop(context);
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
        builder: (context) => SignUpPage2(), //ResetPasswordPage(),
      ),
    );
    setState(() {
      _loading = false;
    });
  }

  Future<void> _verifyUser() async {
    try {
      final response = await http.post(
        Uri.parse(
            "$uri/verificar-usuario"), // Substitua pelo endereço correto da sua API
        body: jsonEncode({
          'cpf': _cpfController.text.replaceAll(".", "").replaceAll("-", ""),
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['exists']) {
          // Usuário já cadastrado, exibir mensagem
          showAlertDialog1ok(context, jsonDecode(response.body)['message']);
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
