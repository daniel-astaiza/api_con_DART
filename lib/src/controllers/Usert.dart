import 'dart:convert';
import 'package:http/http.dart' as http;

class Users {
  final String id;
  final String name;
  final String email;

  Users({
    required this.id, // 'id' debe estar presente en el constructor para ser inicializado
    required this.name,
    required this.email,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['_id'], // Aquí 'id' se inicializa con el valor del campo '_id' del JSON
      name: json['nombre'], // Asegúrate de que coincida con el nombre del campo en la respuesta de la API
      email: json['correo'], // Ejemplo de otro campo
    );
  }

  // Método estático para manejar el caso de un usuario vacío
  factory Users.empty() {
    return Users(
      id: '', // Puedes establecerlo como un valor vacío o null según tus necesidades
      name: '',
      email: '',
    );
  }

  // Método getter para obtener el 'id'
  String get getId => id; // Si prefieres, puedes llamar al getter 'getId' en lugar de solo 'id'
}


Future<List<Users>> consultUsers() async {
  final response = await http.get(
    Uri.parse('http://localhost:4000/api/user'),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    // Verifica que jsonList no sea null y sea una lista
    if (jsonList is List) {
      List<Users> usersList = jsonList
          .where((json) => json != null) // Filtra valores nulos
          .map((json) => Users.fromJson(json))
          .toList();
      return usersList;
    } else {
      throw Exception('La respuesta de la API no es una lista válida');
    }
  } else {
    throw Exception('Failed to load users');
  }
}


Future<Users> createUsers(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:4000/api/user'),
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

Future<Users> updateUser(String id, String name, String email) async {
  final response = await http.put(
    Uri.parse('http://localhost:4000/api/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
    }),
  );

  if (response.statusCode == 200) {
    return Users.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update user');
  }
}
