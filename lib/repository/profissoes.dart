import 'dart:math';

import 'package:Carrrabicho/models/profissional.dart';
import 'package:Carrrabicho/models/result_profissional.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';

class Profissaorepository {
  static var listProfissao = [
    "Adestrador",
    "Cuidador",
    "Hotel",
    "Veterinário",
  ];
}

class VeterinarioRepository {
  static List<Profissional> tabela = List.generate(20, (index) {
    final faker = Faker();
    final nome = faker.person.firstName();
    final localizacao = faker.address.city();
    final preco = faker.randomGenerator.integer(min(50, 500));

    return Profissional(
      nome: nome,
      localizacao: localizacao,
      preco: double.parse(preco.toString()),
    );
  });
}


class CuidadorRepository {
  static List<ResultProfissional> tabela = List.generate(20, (index) {
    final faker = Faker();
    final nome = faker.person.firstName();
    final localizacao = faker.address.city();
    final preco = faker.randomGenerator.string(min(50, 500));

    return ResultProfissional(
    
      nome: nome,
      cidade: localizacao,
      valor: preco
    );
  });
}

class AdestradorRepository {
  static List<ResultProfissional> tabela = List.generate(20, (index) {
    final faker = Faker();
    final nome = faker.person.firstName();
    final localizacao = faker.address.city();
    final preco = faker.randomGenerator.string(min(50, 500));

    return ResultProfissional(
      nome: nome,
      cidade: localizacao,
      valor: preco
    );
  });
}

class HotelRepository {
  static List<ResultProfissional> tabela = List.generate(20, (index) {
    final faker = Faker();
    final nome = faker.person.firstName();
    final localizacao = faker.address.city();
    final preco = faker.randomGenerator.string(min(50, 500));

    return ResultProfissional(
      nome: nome,
      cidade: localizacao,
      valor: preco
    );
  });
}