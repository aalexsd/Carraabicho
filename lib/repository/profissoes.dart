import 'dart:math';

import 'package:Carrrabicho/models/profissional.dart';
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
      foto: 'assets/images/veterinario1.jpeg',
      nome: nome,
      localizacao: localizacao,
      preco: double.parse(preco.toString()),
    );
  });
}


class CuidadorRepository {
  static List<Profissional> tabela = List.generate(20, (index) {
    final faker = Faker();
    final nome = faker.person.firstName();
    final localizacao = faker.address.city();
    final preco = faker.randomGenerator.integer(min(50, 500));

    return Profissional(
      foto: 'assets/images/cuidadorbonito.avif',
      nome: nome,
      localizacao: localizacao,
      preco: double.parse(preco.toString()),
    );
  });
}

class AdestradorRepository {
  static List<Profissional> tabela = List.generate(20, (index) {
    final faker = Faker();
    final nome = faker.person.firstName();
    final localizacao = faker.address.city();
    final preco = faker.randomGenerator.integer(min(50, 500));

    return Profissional(
      foto: 'assets/images/adestrador1.jpeg',
      nome: nome,
      localizacao: localizacao,
      preco: double.parse(preco.toString()),
    );
  });
}

class HotelRepository {
  static List<Profissional> tabela = List.generate(20, (index) {
    final faker = Faker();
    final nome = faker.person.firstName();
    final localizacao = faker.address.city();
    final preco = faker.randomGenerator.integer(min(50, 500));

    return Profissional(
      foto: 'assets/images/hotel4.jpg',
      nome: nome,
      localizacao: localizacao,
      preco: double.parse(preco.toString()),
    );
  });
}