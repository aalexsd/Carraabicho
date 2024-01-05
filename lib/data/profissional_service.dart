import '../bloc/wsf_param.dart';
import '../models/result_pessoa.dart';
import 'package:http/http.dart' as http;

class ProfessionalService {

  static Future getProfissional() async {
    return await http.get(
      Uri.parse(Wsf().baseurl() + '/profissionais/Veterinário'),
    );
  }
}
