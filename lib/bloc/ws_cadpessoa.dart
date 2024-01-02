import 'dart:convert';

import 'package:Carrrabicho/bloc/wsf_param.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<bool> cadUsuario(usuario) async {
    var data = {
      "nome": usuario.nome,
      "sobrenome": usuario.sobrenome,
      "cpf": usuario.cpf,
      "email": usuario.email,
      "cel": usuario.celular,
      "nasc": usuario.nasc,
      "sexo": usuario.sexo,
      "senha": usuario.senha,
      "cep": usuario.cep,
      "endereco": usuario.endereco,
      "nro": (usuario.numero == null) ? "N/A" : usuario.numero.toString(),
      "complemento": (usuario.complemento == null)
          ? "N/A"
          : usuario.complemento.toString(),
      "bairro": usuario.bairro,
      "cidade": usuario.cidade,
      "uf": usuario.uf,
    };
    print(data);

    var data2 = json.encode(data);

    final response = await http.post(Uri.parse(Wsf().baseurl() + 'cadastro'),
        body: data2, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }
}
