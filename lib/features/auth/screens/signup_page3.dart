import 'dart:convert';
import 'dart:io';

import 'package:Carrrabicho/commmon/widgets/custom_button.dart';
import 'package:Carrrabicho/commmon/widgets/custom_textfield.dart';
import 'package:Carrrabicho/constants/globalvariable.dart';
import 'package:Carrrabicho/features/auth/screens/login_page.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../commmon/widgets/alert.dart';
import '../../../models/user.dart';
import '../../../providers/user.provider.dart';
import '../services/auth_service.dart';

class SignUpPage3 extends StatefulWidget {
  static const String routeName = '/singup3';
  SignUpPage3({super.key});

  @override
  State<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _valorController = TextEditingController();
  final _confirmPassowrdController = TextEditingController();
  final AuthService authService = AuthService();

  bool loading = false;
  bool isUsuario = true;
  var usuarioSelecionado;
  bool showPassword = false;
  bool showPassword2 = false;
  String? selectedProfissao;

  @override
  void initState() {
    super.initState();
  }

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      showPassword2 = !showPassword2;
    });
  }

  List<String> listaProfissionais = [
    'Adestrador',
    'Cuidador',
    'Hotel',
    'Passeador',
    'PetShop',
    'Veterinário'
  ];

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;
    var user = Provider.of<UserProvider>(context).user;

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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
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
                      width: screenW * .9,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomRadioButton(
                            enableShape: true,
                            autoWidth: true,
                            elevation: 0,
                            absoluteZeroSpacing: false,
                            unSelectedColor: Theme.of(context).canvasColor,
                            buttonLables: [
                              'Sou usuário',
                              'Sou prestador',
                            ],
                            buttonValues: [
                              "USUARIO",
                              "PRESTADOR",
                            ],
                            buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black,
                                textStyle: TextStyle(fontSize: 16)),
                            radioButtonValue: (value) {
                              if (value == "PRESTADOR") {
                                setState(() {
                                  user.isUsuario = 'N';
                                  isUsuario = false;
                                });
                              } else {
                                setState(() {
                                  user.isUsuario = 'S';
                                  isUsuario = true;
                                });
                              }
                            },
                            selectedColor: Colors.indigo),
                        SizedBox(
                          height: 10,
                        ),
                        (user.isUsuario == 'S')
                            ? Column(
                                children: [
                                  CustomTextField(
                                    controller: _emailController,
                                    hintText: "Email",
                                    onSaved: () {
                                      setState(() {
                                        user.email = _emailController.text;
                                      });
                                    },
                                  ),
                                  CustomTextField(
                                      onSaved: () {
                                        setState(() {
                                          user.senha = _passwordController.text;
                                        });
                                      },
                                      controller: _passwordController,
                                      hintText: 'Senha',
                                      obscureText: !showPassword,
                                      suffixIcon: IconButton(
                                        onPressed: _togglePasswordVisibility,
                                        icon: Icon(
                                          showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                      )),
                                  CustomTextField(
                                    onSaved: () {},
                                    controller: _confirmPassowrdController,
                                    hintText: 'Confirme sua senha',
                                    obscureText: !showPassword2,
                                    suffixIcon: IconButton(
                                      onPressed: _togglePasswordVisibility2,
                                      icon: Icon(
                                        showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.menu(
                                        fit: FlexFit.tight,
                                        showSelectedItems: true,
                                        showSearchBox: false,
                                      ),
                                      items: listaProfissionais,
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border: OutlineInputBorder(),
                                          prefixIcon: Icon(Icons.shopping_bag),
                                          hintText: 'Tipo de Prestador',
                                          labelText: 'Tipo de Prestador',
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Selecione o Tipo de Serviço';
                                        }
                                        return null; // Retorna null se o campo estiver preenchido corretamente
                                      },
                                    
                                      onSaved: (value) {
                                        setState(() {
                                          selectedProfissao = value;
                                          user.tipoProfissional = selectedProfissao;
                                        });
                                      },
                                    ),
                                  ),
                                  
                                  CustomTextField(
                                    controller: _valorController,
                                    hintText: "Valor",
                                    onSaved: () {
                                      setState(() {
                                        user.valor = _valorController.text;
                                      });
                                    },
                                  ),
                                  CustomTextField(
                                    controller: _emailController,
                                    hintText: "Email",
                                    onSaved: () {
                                      setState(() {
                                        user.email = _emailController.text;
                                      });
                                    },
                                  ),
                                  CustomTextField(
                                      onSaved: () {
                                        setState(() {
                                          user.senha = _passwordController.text;
                                        });
                                      },
                                      controller: _passwordController,
                                      hintText: 'Senha',
                                      obscureText: !showPassword,
                                      suffixIcon: IconButton(
                                        onPressed: _togglePasswordVisibility,
                                        icon: Icon(
                                          showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                      )),
                                  CustomTextField(
                                    onSaved: () {},
                                    controller: _confirmPassowrdController,
                                    hintText: 'Confirme sua senha',
                                    obscureText: !showPassword2,
                                    suffixIcon: IconButton(
                                      onPressed: _togglePasswordVisibility2,
                                      icon: Icon(
                                        showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                          child: SizedBox(
                            height: 85,
                            child: CustomButtom(
                              onPressed: () {
                                setState(() {
                                    loading = true;
                                  });
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (isUsuario == null || isUsuario == '') {
                                    showAlertDialog1ok(
                                        context, 'Selecione o tipo de usuário');
                                        setState(() {
                                          loading = false;
                                        });
                                  } else {
                                    _verifyUser();
                                  }
                                  
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: (loading)
                                    ? [
                                        const Padding(
                                          padding: EdgeInsets.all(16),
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      ]
                                    : [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Criar Conta',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Voltar'),
                        )
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpUser() async {
    var user = Provider.of<UserProvider>(context, listen: false).user;

    authService.singUpUser(
      context: context,
      nome: user.nome!,
      sobrenome: user.sobrenome!,
      cpf: user.cpf!,
      email: user.email!,
      telefone: user.telefone!,
      nasc: user.nasc!,
      sexo: user.sexo!,
      cep: user.cep!,
      endereco: user.endereco!,
      nro: user.nro!,
      complemento: user.complemento!,
      bairro: user.bairro!,
      cidade: user.cidade!,
      uf: user.uf!,
      senha: user.senha!,
      isUsuario: "S",
      valor: "",
      tipoProfissional: ""
    );
  }

  Future<void> signUpProfissional() async {
    var user = Provider.of<UserProvider>(context, listen: false).user;

    authService.singUpProfissional(
      context: context,
      nome: user.nome!,
      sobrenome: user.sobrenome!,
      cpf: user.cpf!,
      email: user.email!,
      telefone: user.telefone!,
      nasc: user.nasc!,
      sexo: user.sexo!,
      cep: user.cep!,
      endereco: user.endereco!,
      nro: user.nro!,
      complemento: user.complemento!,
      bairro: user.bairro!,
      cidade: user.cidade!,
      uf: user.uf!,
      senha: user.senha!,
      valor: user.valor!,
      tipoProfissional: user.tipoProfissional!,
      isUsuario: user.isUsuario!,
    );
  }

  Future<void> _verifyUser() async {
    try {
      final response = await http.post(
        Uri.parse(
            '$uri/verificar-usuario'), // Substitua pelo endereço correto da sua API
        body: jsonEncode({
          'email': _emailController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['exists'] && !isUsuario) {
          showAlertDialog1ok(context, 'Email já cadastrado');
        } else

        if (!data['exists'] && isUsuario) {
          await signUpUser();
          print(isUsuario);
        } else if (!isUsuario!) {
          await signUpProfissional();
          print(isUsuario);
        } else {
          showAlertDialog1ok(context, jsonDecode(response.body)['message']);
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
        loading = false;
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
