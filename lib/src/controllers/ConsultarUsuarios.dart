import 'dart:convert';
import 'package:http/http.dart' as http;

// Cambia el tipo de retorno a Future<List<Users>>
Future<List<Users>> consultarUsuarios() async {
  final response = await http.get(
      Uri.parse('https://nodejs-api-1-iji8.onrender.com/api/user'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Users.fromJson(json)).toList();
  } else {
    throw Exception('Failed ');
  }
}

class Users {
  final String name;
  final String email;

  const Users({
    required this.name,
    required this.email,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      email: json['email'],
    );
  }
}
