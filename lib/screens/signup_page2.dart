import 'package:Carrrabicho/models/result_pessoa.dart';
import 'package:Carrrabicho/screens/signup_page3.dart';
import 'package:Carrrabicho/widgets/block_button.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../data/via_cep_service.dart';

class SignUpPage2 extends StatefulWidget {
  final String nome;
  final String sobrenome;
  final String cpf;
  final String telefone;
  final String nasc;
  final String sexo;
  ResultPessoa? usuario = ResultPessoa();

  SignUpPage2({
    super.key,
    required this.nome,
    required this.sobrenome,
    required this.cpf,
    required this.telefone,
    required this.nasc,
    required this.sexo,
  });

  bool _loading = false;
  String? resultado;
  var _searchCepController = TextEditingController();
  var _endeController = TextEditingController();
  var _bairroController = TextEditingController();
  var _cidadeController = TextEditingController();
  var _ufController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    widget.usuario!.nome = widget.nome;
    widget.usuario!.sobrenome = widget.sobrenome;
    widget.usuario!.cpf = widget.cpf;
    widget.usuario!.celular = widget.telefone;
    widget.usuario!.sexo = widget.sexo;
    widget.usuario!.nasc = widget.nasc;
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: TextFormField(
                            inputFormatters: [
                              // obrigatório
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter()
                            ],
                            focusNode: _fcep,
                            textInputAction: TextInputAction.next,
                            // autofocus: true,
                            controller: widget._searchCepController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Digite o CEP",
                              border: OutlineInputBorder(),
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
                             
                            ),

                            onSaved: (val) {
                              cep = val!;
                            },
                            onFieldSubmitted: (value) => _fcep.nextFocus(),
                            onEditingComplete: () {
                              _fcep.nextFocus();
                              _searchCep();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o CEP!';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // autofocus: true,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: widget._endeController,
                          decoration: InputDecoration(
                            labelText: "Endereço",
                            border: OutlineInputBorder(),
                            
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.text,
                          enabled: false,
                          controller: widget._bairroController,
                          decoration: InputDecoration(
                            labelText: "Bairro",
                            border: OutlineInputBorder(),
                            
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {
                              user.endereco = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.text,
                          enabled: false,
                          controller: widget._cidadeController,
                          decoration: InputDecoration(
                            labelText: "Cidade",
                            border: OutlineInputBorder(),
                            
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {
                              user.cidade = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.text,
                          enabled: false,
                          controller: widget._ufController,
                          decoration: InputDecoration(
                            labelText: "Estado",
                            border: OutlineInputBorder(),
                            
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {
                              user.uf = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onSaved: (val) {
                            widget.usuario!.complemento = val!;
                          },
                          // autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Complemento (Apto / Bloco / Casa)",
                            border: OutlineInputBorder(),
                         
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {
                              user.complemento = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onSaved: (val) {
                            widget.usuario!.numero = val!;
                          },
                          // autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Número",
                            border: OutlineInputBorder(),
                           
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o Número!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              user.numero = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 5),
                          child: BlockButton(
                            onPressed: () {
                              
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() {
                                _loading = true;
                              });
                                create1(context);
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

  create1(BuildContext context) {
    setState(() {
      _loading = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignUpPage3(usuario: widget.usuario!)),
    );
    setState(() {
      _loading = false;
    });
  }

  Future _searchCep() async {
    _loadingCep = true;

    final cep = widget._searchCepController.text;

    final resultCep = await ViaCepService.fetchCep(cep: cep);

    if (resultCep == null) {
      print('CEP não encontrado. Verifique e tente novamente!');
    } else {
      setState(() {
        widget._endeController.text = resultCep.logradouro!;
        widget._bairroController.text = resultCep.bairro!;
        widget._cidadeController.text = resultCep.localidade!;
        widget._ufController.text = resultCep.uf!;

        widget.usuario!.cep = cep;
        widget.usuario!.endereco = resultCep.logradouro;

        widget.usuario!.bairro = resultCep.bairro;
        widget.usuario!.cidade = resultCep.localidade;
        widget.usuario!.uf = resultCep.uf;
      });
    }

    _loadingCep = false;
  }
}
