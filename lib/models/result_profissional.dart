class ResultProfissional {
  int? id;
  String? nome;
  String? sobrenome;
  String? cpf;
  String? email;
  String? telefone;
  String? nasc;
  String? sexo;
  String? senha;
  String? cep;
  String? endereco;
  String? nro;
  String? complemento;
  String? bairro;
  String? cidade;
  String? uf;
  String? tipo;
  String? valor;
  String? createdAt;
  String? updatedAt;

  ResultProfissional(
      {this.id,
      this.nome,
      this.sobrenome,
      this.cpf,
      this.email,
      this.telefone,
      this.nasc,
      this.sexo,
      this.senha,
      this.cep,
      this.endereco,
      this.nro,
      this.complemento,
      this.bairro,
      this.cidade,
      this.uf,
      this.tipo,
      this.valor,
      this.createdAt,
      this.updatedAt});

  ResultProfissional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    sobrenome = json['sobrenome'];
    cpf = json['cpf'];
    email = json['email'];
    telefone = json['telefone'];
    nasc = json['nasc'];
    sexo = json['sexo'];
    senha = json['senha'];
    cep = json['cep'];
    endereco = json['endereco'];
    nro = json['nro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    uf = json['uf'];
    tipo = json['tipo'];
    valor = json['valor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['sobrenome'] = this.sobrenome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['nasc'] = this.nasc;
    data['sexo'] = this.sexo;
    data['senha'] = this.senha;
    data['cep'] = this.cep;
    data['endereco'] = this.endereco;
    data['nro'] = this.nro;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['uf'] = this.uf;
    data['tipo'] = this.tipo;
    data['valor'] = this.valor;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}