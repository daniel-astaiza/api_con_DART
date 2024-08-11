import 'package:api/src/controllers/Usert.dart';
import 'package:http/http.dart' as http;

Future<Users> deleteUsers(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://fluttermercadolibre.onrender.com/api/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Users.empty();
  } else {
    throw Exception('Failed to delete user');
  }
}