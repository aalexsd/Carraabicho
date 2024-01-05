import 'dart:convert';


class ResultPessoa {
  int? id;
  String? cpf;
  String? nome;
  String? codigo;
  String? email;
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
  String? ibge;
  String? senha;
  String? sobrenome;
  String? tipo;
  String? valor;
  String? isUsuario;


  ResultPessoa({
    this.id,
    this.cpf,
    this.nome,
    this.codigo,
    this.email,
    this.nasc,
    this.celular,
    this.sexo,
    this.cep,
    this.endereco,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.uf,
    this.ibge,
    this.senha,
    this.sobrenome,
        this.tipo,
            this.valor,
            this.isUsuario
  });
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
        uf: json["uf"],
        ibge: json["ibge"],
        senha: json["senha"],
        sobrenome: json["sobrenome"],
        tipo: json["tipo"],
        valor: json["valor"],
        isUsuario: json["isUsuario"],
      );

//factory ResultPessoa.fromJson(String str) =>
  //ResultPessoa.fromMap(json.decode(str));

//factory ResultPessoa.fromJson(String str) =>
  //     ResultPessoa.fromMap(json.decode(str));

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
        uf: json["uf"],
        ibge: json["ibge"],
        senha: json["senha"],
        sobrenome: json["sobrenome"],
        tipo: json["tipo"],
        valor: json["valor"],
        isUsuario: json["isUsuario"],
      );

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
        "uf": uf,
        "ibge": ibge,
        "senha": senha,
         "sobrenome": sobrenome,
         "tipo": tipo,
         "valor": valor,
         "isUsuario": isUsuario,
      };
}

ResultPessoa user = new ResultPessoa();
