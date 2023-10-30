import 'dart:convert';

class IDUser {
  String id = '';
  String nome = '';
  String email = '';
  String cpf = '';
}

class ResultPessoa {
  int? id;
  String? cpf;
  String? nome;
  String? codigo;
  String email;
  String? nasc;
  String? celular;
  String? sexo;
  String? cep;
  String? endereco;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? uf;
  String senha;
  String? tipoServico;

  ResultPessoa(
      {required this.id,
      required this.cpf,
      required this.nome,
      required this.codigo,
      required this.email,
      required this.nasc,
      required this.celular,
      required this.sexo,
      required this.cep,
      required this.endereco,
      required this.numero,
      required this.complemento,
      required this.bairro,
      required this.cidade,
      required this.senha,
      required this.tipoServico,
      required this.uf,});
  factory ResultPessoa.fromJson(Map<String, dynamic> json) => ResultPessoa(
      id: json["id"],
      cpf: json["cpf"],
      nome: json["nome"],
      codigo: json["codigo"],
      email: json["email"],
      nasc: json["nasc"],
      celular: json["celular"],
      sexo: json["sexo"],
      cep: json["cep"],
      endereco: json["endereco"],
      numero: json["numero"],
      complemento: json["complemento"],
      bairro: json["bairro"],
      cidade: json["cidade"],
      senha: json["senha"],
      tipoServico: json["tipoServico"],
      uf: json["uf"],);


  String toJson() => json.encode(toMap());

  factory ResultPessoa.fromMap(Map<String, dynamic> json) => ResultPessoa(
      id: json["id"],
      cpf: json["cpf"],
      nome: json["nome"],
      codigo: json["codigo"],
      email: json["email"],
      nasc: json["nasc"],
      celular: json["celular"],
      sexo: json["sexo"],
      cep: json["cep"],
      endereco: json["endereco"],
      numero: json["numero"],
      complemento: json["complemento"],
      bairro: json["bairro"],
      cidade: json["cidade"],
      senha: json["senha"],
      tipoServico: json["tipoServico"],
      uf: json["uf"],);

  Map<String, dynamic> toMap() => {
        "id": id,
        "cpf": cpf,
        "nome": nome,
        "codigo": codigo,
        "email": email,
        "nasc": nasc,
        "celular": celular,
        "sexo": sexo,
        "cep": cep,
        "endereco": endereco,
        "numero": numero,
        "complemento": complemento,
        "bairro": bairro,
        "cidade": cidade,
        "senha": senha,
        "tipoServico": tipoServico,
        "uf": uf,
      };
}

ResultPessoa user = ResultPessoa(id: 0, cpf: '', nome: '', codigo: '', email: '', nasc: '', celular: '', sexo: '', cep: '', endereco: '', numero: '', complemento: '', bairro: '', cidade: '', uf: '', senha: '', tipoServico: '');
