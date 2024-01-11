import 'dart:convert';

class ResultAgendamento {
  int? id;
  int? idUsuario;
  int? idProfissional;
  String? nomeProfissional;
  String? titulo;
  String? data;
  String? hora;
  String? descricao;
  String? pet;
  int? status;

  ResultAgendamento({
    this.id,
    this.idUsuario,
    this.idProfissional,
    this.nomeProfissional,
    this.titulo,
    this.data,
    this.hora,
    this.descricao,
    this.pet,
    this.status,
  });
  factory ResultAgendamento.fromJson(Map<String, dynamic> json) =>
      ResultAgendamento(
        id: json["id"],
        idUsuario: json["idUsuario"],
        idProfissional: json["idProfissional"],
        nomeProfissional: json["nomeProfissional"],
        titulo: json["titulo"],
        data: json["data"],
        hora: json["hora"],
        descricao: json["descricao"],
        pet: json["pet"],
        status: json["status"],
      );

  String toJson() => json.encode(toMap());

  factory ResultAgendamento.fromMap(Map<String, dynamic> json) =>
      ResultAgendamento(
        id: json["id"],
        idUsuario: json["idUsuario"],
        idProfissional: json["idProfissional"],
        nomeProfissional: json["nomeProfissional"],
        titulo: json["titulo"],
        data: json["data"],
        hora: json["hora"],
        descricao: json["descricao"],
        pet: json["pet"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idUsuario": idUsuario,
        "idProfissional": idProfissional,
        "nomeProfissional": nomeProfissional,
        "titulo": titulo,
        "data": data,
        "hora": hora,
        "descricao": descricao,
        "pet": pet,
        "status": status,
      };
}

ResultAgendamento agendamento = new ResultAgendamento();
