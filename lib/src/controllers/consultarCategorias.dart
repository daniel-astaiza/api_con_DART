import 'dart:convert';
import 'package:http/http.dart' as http;

// Cambia el tipo de retorno a Future<List<Users>>
Future<List<Users>> consultarCategoria() async {
  final response = await http.get(
      Uri.parse('https://fluttermercadolibre.onrender.com/api/categorie'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Users.fromJson(json)).toList();
  } else {
    throw Exception('Failed ');
  }
}

class Users {
  final String name;
  

  const Users({
    required this.name
    
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
    );
  }
}
