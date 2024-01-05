import 'dart:convert';
import 'dart:io';

import 'package:Carrrabicho/repository/profissoes.dart';
import 'package:Carrrabicho/screens/login_page.dart';
import 'package:Carrrabicho/widgets/block_button.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Services/auth_services.dart';
import '../bloc/ws_cadpessoa.dart';
import '../bloc/wsf_param.dart';
import '../data/via_cep_service.dart';
import '../models/result_pessoa.dart';
import '../widgets/alert.dart';

class SignUpPage3 extends StatefulWidget {
  var usuario = ResultPessoa();
  SignUpPage3({super.key, required this.usuario});

  @override
  State<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
  final _formKey = GlobalKey<FormState>();
  final senha = TextEditingController();
  final email = TextEditingController();
   final valor = TextEditingController();
  final confirmasenha = TextEditingController();

  bool loading = false;
  bool isUsuario = true;
  var usuarioSelecionado;
  bool showPassword = false;
  String? selectedProfissao;
  late File? _pickedImage; 

  @override
  void initState() {
    super.initState();
  }

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .registrar(email.text, senha.text, context);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  saveAll() async {
    // Criar uma instância do Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Criar um documento no Firestore
    DocumentReference docRef = firestore.collection('usuarios').doc();

    // Definir os dados a serem salvos
    Map<String, dynamic> data = {
      'nome': user.nome,
      'cpf': user.cpf,
      'email': user.email,
      'telefone': user.celular,
      'cep': user.cep,
      'rua': user.endereco,
      'bairro': user.bairro,
      'cidade': user.cidade,
      'estado': user.uf,
      'complemento': user.complemento,
      'numero': user.numero,

      // Adicione outros campos aqui com os respectivos valores
    };

    // Salvar os dados no Firestore
    try {
      await docRef.set(data);
      //print('Dados salvos com sucesso!');
    } catch (e) {
      //print('Erro ao salvar os dados: $e');
    }
  }

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
                                  isUsuario = false;
                                  widget.usuario.isUsuario = "N";
                                });
                              } else {
                                setState(() {
                                  isUsuario = true;
                                  widget.usuario.isUsuario = "S";
                                });
                              }
                            },
                            selectedColor: Colors.indigo),
                        // Row(
                        //   children: [
                        //     Radio<bool>(
                        //       autofocus: true,
                        //       value: true,
                        //       groupValue: tipoUsuario,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           tipoUsuario = value!;
                        //         });
                        //       },
                        //     ),
                        //     const Text('Sou usuário'),
                        //     Radio<bool>(
                        //       value: false,
                        //       groupValue: tipoUsuario,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           tipoUsuario = value!;
                        //         });
                        //       },
                        //     ),
                        //     const Text('Sou prestador de serviço'),
                        //   ],
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        (isUsuario)
                            ? Column(
                                children: [
                                  TextFormField(
                                    controller: email,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.email),
                                      hintText: 'Digite seu E-mail',
                                      labelText: 'Email',
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Informe o email corretamente!';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        widget.usuario.email = value!;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: TextFormField(
                                      obscureText: !showPassword,
                                      controller: senha,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.lock),
                                        hintText: 'Digite sua Senha',
                                        labelText: 'Senha',
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
                                          return 'Informa sua senha!';
                                        } else if (value.length < 6) {
                                          return 'Sua senha deve ter no mínimo 6 caracteres';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          widget.usuario.senha = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: TextFormField(
                                      obscureText: !showPassword,
                                      controller: confirmasenha,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.lock),
                                        hintText: 'Digite sua Senha',
                                        labelText: 'Confirme sua senha',
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
                                      validator: (String? value) {
                                        if (valueValidator(value)) {
                                          return 'Confirme sua Senha';
                                        }
                                        if (value!.length < 6) {
                                          return 'Senha deve ter no mínimo 6 dígitos!';
                                        }

                                        if (value != senha.text) {
                                          return 'Senhas não são iguais';
                                        }

                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.menu(
                                        fit: FlexFit.tight,
                                        showSelectedItems: true,
                                        showSearchBox: false,
                                      ),
                                      items: Profissaorepository.listProfissao,
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
                                      onChanged: (value) {
                                        setState(() {
                                          selectedProfissao = value;
                                          widget.usuario.tipo = selectedProfissao;
                                        
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: TextFormField(
                                      controller: valor,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.monetization_on),
                                        hintText: 'Digite o valor',
                                        labelText: 'Valor',
                                      ),
                                      onSaved: (value){
                                        setState(() {
                                          widget.usuario.valor = value!;
                                        });
                                      },
                                      
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Informe o valor corretamente!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: TextFormField(
                                      controller: email,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.email),
                                        hintText: 'Digite seu E-mail',
                                        labelText: 'Email',
                                      ),
                                      onSaved: (value) {
                                      setState(() {
                                        widget.usuario.email = value!;
                                      });
                                      },
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
                                    padding: const EdgeInsets.only(top: 12),
                                    child: TextFormField(
                                      obscureText: !showPassword,
                                      controller: senha,
                                      onSaved: (value) {
                                      setState(() {
                                        widget.usuario.senha = value!;
                                      });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.lock),
                                        hintText: 'Digite sua Senha',
                                        labelText: 'Senha',
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
                                          return 'Informa sua senha!';
                                        } else if (value.length < 6) {
                                          return 'Sua senha deve ter no mínimo 6 caracteres';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: TextFormField(
                                      obscureText: !showPassword,
                                      controller: confirmasenha,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.lock),
                                        hintText: 'Digite sua Senha',
                                        labelText: 'Confirme sua senha',
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
                                          return 'Informa sua senha!';
                                        } else if (value.length < 6) {
                                          return 'Sua senha deve ter no mínimo 6 caracteres';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                          child: SizedBox(
                            height: 85,
                            child: BlockButton(
                              onPressed: () {
                                print(user.cep);
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  setState(() {
                                    loading = true;
                                  });
                                  _verifyUser();
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

  create1(BuildContext context) async {
    setState(() {
      loading = true;
    });

    var res = await API.cadUsuario(widget.usuario);

    setState(() {
      loading = false;
    });

    if (res) {
      // Usuário criado com sucesso

      // Agora, você pode navegar para a tela de login
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
      BotToast.showText(
        text: "Usuário criado com sucesso!",
        textStyle: TextStyle(
            fontSize: 26, fontWeight: FontWeight.w500, color: Colors.white),
        contentColor: Colors.green,
        align: Alignment(0.7, 0.9),
        duration: Duration(seconds: 3),
      );
    } else {
      // Erro ao cadastrar usuário
      showAlertDialog1ok(
          context, 'Erro ao cadastrar usuário, tente novamente!');
    }
  }

  createProfissional(BuildContext context) async {

    var res = await API.cadProfissional(widget.usuario);

  }

  Future<void> _verifyUser() async {
    try {
      final response = await http.post(
        Uri.parse(Wsf().baseurl() +
            'verificar-usuario'), // Substitua pelo endereço correto da sua API
        body: jsonEncode({
          'email': email.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['exists']) {
          // Usuário já cadastrado, exibir mensagem
          showAlertDialog1ok(context, data['message']);
        } else if (!isUsuario){
          await createProfissional(context);
           await create1(context);
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
