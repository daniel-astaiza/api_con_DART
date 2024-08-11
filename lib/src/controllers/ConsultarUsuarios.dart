import 'dart:convert';
import 'package:http/http.dart' as http;

// Cambia el tipo de retorno a Future<List<Users>>
Future<List<Users>> consultarUsuarios() async {
  final response = await http.get(
      Uri.parse('https://fluttermercadolibre.onrender.com/api/user'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Users.fromJson(json)).toList();
  } else {
    throw Exception('Failed ');
  }
}

class Users {
  final String id;
  final String name;
  final String email;

  const Users({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['_id'] ?? '', // Asegúrate de que el campo 'id' está en el JSON
      name: json['name'],
      email: json['email'],
    );
  }
}

Future<Users> createUsers(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('https://fluttermercadolibre.onrender.com/api/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "name": name,
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode == 201) {
    return Users.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to register user');
  }
}

Future<void> eliminarUsuario(String userId) async {
  final response = await http.delete(
    Uri.parse('https://fluttermercadolibre.onrender.com/api/user/$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete user');
  }
}
Future<void> updateUser(String id, String name, String email) async {
  final response = await http.put(
    Uri.parse('https://fluttermercadolibre.onrender.com/api/user/$id'), // URL de actualización del usuario
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update user: ${response.reasonPhrase}');
  }
}
