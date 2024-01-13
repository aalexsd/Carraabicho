import '../../../constants/globalvariable.dart';
import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class ProfessionalService {

  static Future getProfissional() async {
    return await http.get(
      Uri.parse('$uri/profissionais/Veterinário'),
    );
  }
}
