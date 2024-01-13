// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String? id;
  String? nome;
  String? sobrenome;
  String? cpf;
  String? email;
  String? telefone;
  String? nasc;
  String? sexo;
  String? cep;
  String? endereco;
  String? nro;
  String? complemento;
  String? bairro;
  String? cidade;
  String? uf;
  String? isUsuario;
  String? type;
  String? token;
  String? senha;
  String? tipoProfissional = '';
  String? valor = '';
  User({
    this.id,
    this.nome,
    this.sobrenome,
    this.cpf,
    this.email,
    this.telefone,
    this.nasc,
    this.sexo,
    this.cep,
    this.endereco,
    this.nro,
    this.complemento,
    this.bairro,
    this.cidade,
    this.uf,
    this.isUsuario,
    this.type,
    this.token,
    this.senha,
    this.tipoProfissional,
    required this.valor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'sobrenome': sobrenome,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'nasc': nasc,
      'sexo': sexo,
      'cep': cep,
      'endereco': endereco,
      'nro': nro,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'isUsuario': isUsuario,
      'type': type,
      'token': token,
      'senha': senha,
      'tipoProfissional': tipoProfissional,
      'valor': valor,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] != null ? map['_id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      sobrenome: map['sobrenome'] != null ? map['sobrenome'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
      nasc: map['nasc'] != null ? map['nasc'] as String : null,
      sexo: map['sexo'] != null ? map['sexo'] as String : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      endereco: map['endereco'] != null ? map['endereco'] as String : null,
      nro: map['nro'] != null ? map['nro'] as String : null,
      complemento:
          map['complemento'] != null ? map['complemento'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      cidade: map['cidade'] != null ? map['cidade'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      isUsuario: map['isUsuario'] != null ? map['isUsuario'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      senha: map['senha'] != null ? map['senha'] as String : null,
      tipoProfissional: map['tipoProfissional'] != null ? map['tipoProfissional'] as String : null,
      valor:  (map['valor'] != null)? map['valor'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
