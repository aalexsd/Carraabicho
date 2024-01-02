import 'package:Carrrabicho/repository/profissoes.dart';
import 'package:Carrrabicho/screens/bottom_nav_screen.dart';
import 'package:Carrrabicho/screens/home_screen.dart';
import 'package:Carrrabicho/screens/signup.dart';
import 'package:Carrrabicho/widgets/block_button.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../Services/auth_services.dart';
import '../bloc/ws_login.dart';
import '../widgets/alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String subtitulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;
  bool showPassword = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
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

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
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

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void onForgotPasswordClicked(BuildContext context) {
    Navigator.of(context).pushNamed('/forgot_password');
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
                  height: screenH * .1,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 12),
                                child: TextFormField(
                                  controller: email,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email),
                                    hintText: 'Digite seu E-mail',
                                    labelText: 'Email',
                                    
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 12),
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
                                            top: 12.0, right: 12, bottom: 12),
                                        child: Text(
                                          showPassword ? 'Ocultar' : 'Exibir',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                ),
                              ),
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
                                        onForgotPasswordClicked(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          BlockButton(
                              onPressed: () {
                                setState(() {
                                  _loading = true;
                                });
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();

                                  _clicklogin(
                                      context, email.text, senha.text);
                                }
                              },
                              child: _loading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text("Entrar")),
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
                                  onPressed: () {
                                    signInWithGoogle();
                                  },
                                ),
                              ),
                            ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
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

  _clicklogin(BuildContext context, String login, String senha) async {
    var ret = false;
    if (login.isEmpty || senha.isEmpty) {
      showAlertDialog1ok(context, "Login e/ou Senha em branco")
          .then((value) => setState(() => _loading = false));
    } else {
      setState(() => _loading = true);

      ret = await myLogin(login, senha);
      setState(() => _loading = false);

      if (ret) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavScreen(),
          ),
        );
      } else {
        showAlertDialog1ok(context, "Login e/ou Senha inválido(s)");
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => BottomNavScreen()),
        );
      }
    } catch (e) {}
  }
}
