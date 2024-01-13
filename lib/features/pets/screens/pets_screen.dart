import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/globalvariable.dart';
import '../../../models/user.dart';
import '../../../providers/user.provider.dart';
import 'adicionar_pet.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  List<Map<String, dynamic>> pets = [];
  var userid;

  @override
  void initState() {
    super.initState();
    loadPets();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    setState(() {
          userid = user.id;
    });
    print(userid);


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        
          title: const Text('Meus Pets'),
          actions: [
            Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  height: 35,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
      body: 
      pets.length == 0 ? Center(child: Text('Nenhum pet cadastrado. Cadastre um agora mesmo no botão abaixo.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),) :
      
      ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.tealAccent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${pets[index]['nomePet']}, ${pets[index]['tipoPet']}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.pets,
                        size: 30,
                        color: Colors.brown,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
              
                  _buildPetInfo('Raça', pets[index]['raca']),
                  _buildPetInfo('Cor', pets[index]['cor']),
                  _buildPetInfo('Peso', '${pets[index]['peso']} Kg'),
                  _buildPetInfo('Idade', '${pets[index]['idade']} anos'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Adicionar Pet",
        backgroundColor: Colors.black87,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPetScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<http.Response> getPets() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    var url = Uri.parse('$uri/pets/${user.id}');
    print(url);
    return await http.get(url);
  }

  void loadPets() async {
    try {
      final response = await getPets();
      if (response.statusCode == 200) {
        print(response.body);
   
        // Decodifica o corpo da resposta JSON
        final List<dynamic> petsData = json.decode(response.body);
        // print(petsData);
        // Mapeia os dados recebidos para a lista de agendamentos
        List<Map<String, dynamic>> petsList =
            List<Map<String, dynamic>>.from(petsData);

        setState(() {
          pets = petsList;
        });
      } else {

        // Se a requisição não foi bem-sucedida, trata o erro
        print('Erro ao carregar agendamentos: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao carregar agendamentos: $error');
    }
  }

  Widget _buildPetInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
