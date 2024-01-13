import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      nome: '',
      sobrenome: '',
      cpf: '',
      email: '',
      telefone: '',
      nasc: '',
      sexo: '',
      cep: '',
      endereco: '',
      nro: '',
      complemento: '',
      bairro: '',
      cidade: '',
      uf: '',
      isUsuario: '',
      type: '',
      token: '',
      senha: '',
      valor: '',
      tipoProfissional: ''
      );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
