import 'package:Carrrabicho/repository/profissoes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/via_cep_service.dart';

class SignUpPage3 extends StatefulWidget {
  SignUpPage3({super.key});

  bool _loading = false;
  String? resultado;

  @override
  State<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool tipoUsuario = true;
  var usuarioSelecionado;
  bool showPassword = false;
  final senha = TextEditingController();
  final confirmasenha = TextEditingController();
  String? selectedProfissao;

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
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
                      width: screenW * .88,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Radio<bool>(
                              autofocus: true,
                              value: true,
                              groupValue: tipoUsuario,
                              onChanged: (value) {
                                setState(() {
                                  tipoUsuario = value!;
                                });
                              },
                            ),
                            const Text('Sou usuário'),
                            Radio<bool>(
                              value: false,
                              groupValue: tipoUsuario,
                              onChanged: (value) {
                                setState(() {
                                  tipoUsuario = value!;
                                });
                              },
                            ),
                            const Text('Sou prestador de serviço'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        (tipoUsuario)
                            ? Column(
                                children: [
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
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                                    padding: const EdgeInsets.only(
                                        left: 24, right: 24, top: 12),
                                    child: TextFormField(
                                      obscureText: !showPassword,
                                      controller: confirmasenha,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.lock),
                                        hintText: 'Digite sua Senha',
                                        labelText: 'Confirme sua senha',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8),
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
                              )
                            : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 24.0, right: 24),
                                  child: DropdownSearch<String>(
                          popupProps: PopupProps.dialog(
                                    fit: FlexFit.tight,
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    scrollbarProps: ScrollbarProps()),
                          items: Profissaorepository.listProfissao,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                    ),
                                    hintText: 'Tipo de Prestador',
                                    labelText: 'Tipo de Prestador',
                                  ),
                          ),
                          validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Selecione o servico';
                                  }
                                  return null; // Retorna null se o campo estiver preenchido corretamente
                          },
                          onChanged: (value) {
                                  setState(() {
                                    selectedProfissao = value;
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
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
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
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, top: 12),
                                  child: TextFormField(
                                    obscureText: !showPassword,
                                    controller: confirmasenha,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: 'Digite sua Senha',
                                      labelText: 'Confirme sua senha',
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
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
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 5, left: 24, right: 24),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: (loading)
                                  ? [
                                      const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ]
                                  : [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Criar Conta',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
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
}
