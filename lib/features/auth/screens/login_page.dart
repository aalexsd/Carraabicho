import 'package:Carrrabicho/commmon/widgets/bottom_nav_screen.dart';
import 'package:Carrrabicho/commmon/widgets/custom_button.dart';
import 'package:Carrrabicho/commmon/widgets/custom_textfield.dart';
import 'package:Carrrabicho/features/auth/screens/signup_page.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../../commmon/widgets/alert.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/auth_scnreen';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String subtitulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;
  bool showPassword = false;
  bool _loading = false;
  bool isUsuario = true;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  void signInUser() {
    authService.singInUser(
        context: context,
        email: _emailController.text,
        senha: _passwordController.text);
  }

  void singInProfissional() {
    authService.singInProfissional(
        context: context,
        email: _emailController.text,
        senha: _passwordController.text);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Bem-vindo';
        subtitulo = 'Entre na sua conta';
        actionButton = 'Entrar';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
      } else {
        titulo = 'Registre-se';
        subtitulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login.';
      }
    });
  }

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
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenH * .08,
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
                            "Bem-vindo",
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1.5,
                            ),
                          ),
                          Text(
                            "Entre na sua conta",
                            style: const TextStyle(
                                color: Colors.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -1),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              CustomRadioButton(
                                  defaultSelected: "USUARIO",
                                  enableShape: true,
                                  autoWidth: true,
                                  elevation: 0,
                                  absoluteZeroSpacing: false,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
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
                                      });
                                    } else {
                                      setState(() {
                                        isUsuario = true;
                                      });
                                    }
                                  },
                                  selectedColor: Colors.indigo),
                              CustomTextField(
                                  onSaved: () {},
                                  controller: _emailController,
                                  hintText: 'Email'),
                              CustomTextField(
                                  onSaved: () {},
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
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        'Esqueceu sua senha?',
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                      onPressed: () {
                                        // onForgotPasswordClicked(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          CustomButtom(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  if (isUsuario) {
                                    signInUser();
                                  } else {
                                    singInProfissional();
                                  }
                                }
                              },
                              child: _loading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Entrar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                          if (isLogin)
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      thickness: 2,
                                      indent: 50,
                                      endIndent: 10,
                                    ),
                                  ),
                                  Text("ou"),
                                  Expanded(
                                    child: Divider(
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (isLogin)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: SignInButton(
                                  Buttons.google,
                                  text: 'Entre com o Google',
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignUpPage.routeName);
                            },
                            child: Text(
                              toggleButton,
                              style: const TextStyle(color: Colors.indigo),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
