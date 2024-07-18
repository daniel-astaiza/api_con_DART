import 'package:api/src/screens/01_Home.dart';
import 'package:api/src/screens/02_inicioSesionUsuario.dart';
import 'package:api/src/screens/03_registroUsuario.dart';
import 'package:flutter/material.dart';

class API extends StatelessWidget {
  const API({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "API APP",
      home: HomePage(),
      // home: PaginaRegistro(),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => Login(),
        '/registro': (context) => PaginaRegistro(),
      },
    );
  }
}
