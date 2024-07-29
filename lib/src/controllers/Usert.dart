import 'dart:convert';
import 'package:http/http.dart' as http;
 
//1
 
Future<Users> createUsers(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('https://nodejs-api-1-iji8.onrender.com/api/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{"name": name, "email": email, "password": password}),
  );
 
  if (response.statusCode == 201) {
    return Users.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('No es posible registrarse');
  }
}
 
//2
Future<List<Users>> consultUsers() async {
  final response = await http.get(
      Uri.parse('https://nodejs-api-1-iji8.onrender.com/api/user'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Users.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load jewelry products');
  }
}
 

//2 
 
class Users {
  final String _id;
  final name;
  final email;
 
  const Users({
    required String id,
    required this.name,
    required this.email,
  }): _id = id;

  Users.empty()
      : _id = '',
        name = '',
        email = '';
 
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
  //obtener id
  String get id => _id;
}
 
//3
 
Future<Users> deleteUsers(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://nodejs-api-1-iji8.onrender.com/api/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
 
  if (response.statusCode == 200) {
    return Users.empty();
  } else {
    throw Exception('Failed to delete album.');
  }
}
