import 'dart:convert';

import 'package:Carrrabicho/bloc/wsf_param.dart';
import 'package:http/http.dart' as http;
import '../models/result_pessoa.dart';

Future<bool> myLogin(login, senha) async {
  var data = {"email": login, "senha": senha};
  var data2 = json.encode(data);

  final response = await http.post(Uri.parse(Wsf().baseurl() + 'loginUsuario'),
      body: data2, headers: {"Content-Type": "application/json"});
  if (response.statusCode == 200) {
    user = ResultPessoa.fromJson(jsonDecode(response.body));
    if (user.id! > 0) {
      return true;
    } else
      return false;
  } else {
    return false;
  }
}

Future<bool> myLoginProfissional(login, senha) async {
  var data = {"email": login, "senha": senha};
  var data2 = json.encode(data);

  final response = await http.post(Uri.parse(Wsf().baseurl() + 'loginProfissional'),
      body: data2, headers: {"Content-Type": "application/json"});
  if (response.statusCode == 200) {
    user = ResultPessoa.fromJson(jsonDecode(response.body));
    if (user.id! > 0) {
      return true;
    } else
      return false;
  } else {
    return false;
  }
}
