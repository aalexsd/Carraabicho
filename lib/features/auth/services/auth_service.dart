import 'dart:convert';

import 'package:Carrrabicho/commmon/widgets/bottom_nav_screen.dart';
import 'package:Carrrabicho/features/auth/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/globalvariable.dart';
import '../../../constants/utils.dart';
import '../../../models/user.dart';
import '../../../providers/user.provider.dart';

class AuthService {
  void singUpUser({
    required BuildContext context,
    required String email,
    required String senha,
    required String nome,
    required String sobrenome,
    required String cpf,
    required String telefone,
    required String nasc,
    required String sexo,
    required String cep,
    required String endereco,
    required String nro,
    required String complemento,
    required String bairro,
    required String cidade,
    required String uf,
    required String isUsuario,
    String? valor,
    String? tipoProfissional,
  }) async {
    try {
      User user = User(
          id: '',
          nome: nome,
          sobrenome: sobrenome,
          cpf: cpf,
          senha: senha,
          email: email,
          telefone: telefone,
          nasc: nasc,
          sexo: sexo,
          cep: cep,
          endereco: endereco,
          nro: nro,
          complemento: complemento,
          bairro: bairro,
          cidade: cidade,
          uf: uf,
          valor: valor!,
          tipoProfissional: tipoProfissional!,
          isUsuario: isUsuario,
          type: '',
          token: '');

      var data = user.toJson();
      print(data);
      var headers = {
        'Content-Type': 'application/json',
      };
      print(data);
      final response = await http.post(
          Uri.parse(
            "$uri/api/signup",
          ),
          body: data,
          headers: headers);
      print(response.body);
      print(response.statusCode);

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSuccessSnackBar(context, 'Usuário criado com sucesso.');
            Navigator.pushNamed(context, LoginPage.routeName);
          });
    } catch (e) {
      showErrorSnackBar(context, e.toString());
    }
  }

  void singUpProfissional({
    required BuildContext context,
    required String email,
    required String senha,
    required String nome,
    required String sobrenome,
    required String cpf,
    required String telefone,
    required String nasc,
    required String sexo,
    required String cep,
    required String endereco,
    required String nro,
    required String complemento,
    required String bairro,
    required String cidade,
    required String uf,
    required String isUsuario,
    String? valor,
    String? tipoProfissional,
  }) async {
    try {
      User user = User(
          id: '',
          nome: nome,
          sobrenome: sobrenome,
          cpf: cpf,
          senha: senha,
          email: email,
          telefone: telefone,
          nasc: nasc,
          sexo: sexo,
          cep: cep,
          endereco: endereco,
          nro: nro,
          complemento: complemento,
          bairro: bairro,
          cidade: cidade,
          uf: uf,
          valor: valor!,
          tipoProfissional: tipoProfissional!,
          isUsuario: isUsuario,
          type: '',
          token: '');

      var data = user.toJson();
      var headers = {
        'Content-Type': 'application/json',
      };
      print(data);
      final response = await http.post(
          Uri.parse(
            "$uri/api/signup/profissional",
          ),
          body: data,
          headers: headers);
      print(response.body);
      print(response.statusCode);

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSuccessSnackBar(context, 'Usuário criado com sucesso.');
            Navigator.pushNamed(context, LoginPage.routeName);
          });
    } catch (e) {
      showErrorSnackBar(context, e.toString());
    }
  }

  void singInUser({
    required BuildContext context,
    required String email,
    required String senha,
  }) async {
    try {
      var data = jsonEncode({
        "email": email,
        "senha": senha,
      });
      var headers = {
        'Content-Type': 'application/json',
      };
      print(data);
      final response = await http.post(
          Uri.parse(
            "$uri/api/signin",
          ),
          body: data,
          headers: headers);
      print(response.body);
      print(response.statusCode);

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(response.body)['token']);
            Navigator.of(context)?.pushNamedAndRemoveUntil(
              BottomNavScreen.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showErrorSnackBar(context, e.toString());
    }
  }

  void singInProfissional({
    required BuildContext context,
    required String email,
    required String senha,
  }) async {
    try {
      var data = jsonEncode({
        "email": email,
        "senha": senha,
      });
      var headers = {
        'Content-Type': 'application/json',
      };
      print(data);
      final response = await http.post(
          Uri.parse(
            "$uri/api/signin/profissional",
          ),
          body: data,
          headers: headers);

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(response.body)['token']);
            Navigator.of(context)?.pushNamedAndRemoveUntil(
              BottomNavScreen.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showErrorSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http
          .post(Uri.parse("$uri/tokenIsValid"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      var response = jsonDecode(tokenRes.body);

      if (response) {
        http.Response userRes = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showErrorSnackBar(context, e.toString());
    }
  }
}
