import 'package:Carrrabicho/commmon/widgets/custom_button.dart';
import 'package:Carrrabicho/commmon/widgets/custom_textfield.dart';
import 'package:Carrrabicho/features/auth/screens/signup_page3.dart';
import 'package:Carrrabicho/models/user.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../services/via_cep_service.dart';
import '../../../providers/user.provider.dart';

class SignUpPage2 extends StatefulWidget {
  static const String routeName = '/singup2';
  SignUpPage2({
    super.key,
  });

  bool _loading = false;
  String? resultado;

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  final _formKey = GlobalKey<FormState>();
  var cep = '';
  var ende = '';
  bool? _loading = false;
  bool _loadingCep = false;
  final FocusNode _fcep = FocusNode();
  final _searchCepController = TextEditingController();
  final _endeController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _ufController = TextEditingController();
  final _complementoController = TextEditingController();
  final _nroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/loginBG.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenH * .1,
                ),
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
                        CustomTextField(
                          controller: _searchCepController,
                          hintText: 'CEP',
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter()
                          ],
                          keyboardType: TextInputType.number,
                          suffixIcon: _loadingCep
                              ? CircularProgressIndicator()
                              : IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _searchCep();
                                  },
                                ),
                          onSaved: () {
                            setState(() {
                              user.cep = _searchCepController.text;
                            });
                          },
                        ),
                        CustomTextField(
                          enabled: false,
                          controller: _endeController,
                          hintText: 'Endereço',
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter()
                          ],
                          keyboardType: TextInputType.text,
                          onSaved: () {
                            setState(() {
                              user.endereco = _endeController.text;
                            });
                          },
                        ),
                        CustomTextField(
                          enabled: false,
                          controller: _bairroController,
                          hintText: 'Bairro',
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter()
                          ],
                          keyboardType: TextInputType.text,
                          onSaved: () {
                            setState(() {
                              user.bairro = _bairroController.text;
                            });
                          },
                        ),
                        CustomTextField(
                          enabled: false,
                          controller: _cidadeController,
                          hintText: 'Cidade',
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter()
                          ],
                          keyboardType: TextInputType.text,
                          onSaved: () {
                            setState(() {
                              user.cidade = _cidadeController.text;
                            });
                          },
                        ),
                        CustomTextField(
                          enabled: false,
                          controller: _ufController,
                          hintText: 'Estado',
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter()
                          ],
                          keyboardType: TextInputType.text,
                          onSaved: () {
                            setState(() {
                              user.uf = _ufController.text;
                            });
                          },
                        ),
                        CustomTextField(
                          valida: false,
                          controller: _complementoController,
                          hintText: "Complemento (Apto / Bloco / Casa)",
                          onSaved: () {
                            if(_complementoController.text.isEmpty){
                              setState(() {
                                user.complemento = 'N/A';
                                _complementoController.text = 'N/A';
                              });
                            }
                            setState(() {
                              user.complemento = _complementoController.text;
                            });
                          },
                        ),
                        CustomTextField(
                          controller: _nroController,
                          hintText: "Número",
                          onSaved: () {
                            setState(() {
                              user.nro = _nroController.text;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                          child: CustomButtom(
                            onPressed: () {
                              
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() {
                                  _loading = true;
                                });
                                Navigator.pushNamed(context, SignUpPage3.routeName).then((value) {
                                  setState(() {
                                    _loading = false;
                                  });
                                });
                              }
                            },
                            child: _loading!
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

  Future _searchCep() async {
    _loadingCep = true;

    final cep = _searchCepController.text;

    final resultCep = await ViaCepService.fetchCep(cep: cep);

    if (resultCep == null) {
      print('CEP não encontrado. Verifique e tente novamente!');
    } else {
      setState(() {
        _endeController.text = resultCep.logradouro!;
        _bairroController.text = resultCep.bairro!;
        _cidadeController.text = resultCep.localidade!;
        _ufController.text = resultCep.uf!;
      });
    }

    _loadingCep = false;
  }
}
